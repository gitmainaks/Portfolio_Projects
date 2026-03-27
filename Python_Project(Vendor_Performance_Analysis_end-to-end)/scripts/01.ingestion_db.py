import pandas as pd
import os
from sqlalchemy import create_engine
import logging
import time

# Ensuring logs directory exists
os.makedirs("logs", exist_ok=True)

# Setting up a named logger for this module
logger = logging.getLogger('ingestion_db')
logger.setLevel(logging.DEBUG)
logger.propagate = False    # <-- prevents messages from going to root

# Creating file handler only if not already added
if not logger.handlers:
    file_handler = logging.FileHandler("logs/ingestion_db.log", mode='a')
    formatter = logging.Formatter("%(asctime)s - %(levelname)s - %(message)s")
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)

engine = create_engine('sqlite:///inventory.db')

def ingest_db(df, table_name, engine, if_exists='replace'):
    """
    Ingesting a DataFrame into a database table.
    This function uses chunking internally to avoid memory issues.
    """
    # Using chunksize to insert in batches
    df.to_sql(table_name, con=engine, if_exists=if_exists, index=False, chunksize=10000)

def load_raw_data():
    """
    Loading CSV files from the 'data' directory and ingesting them into the database.
    Each file is processed in chunks to limit memory usage.
    """
    start = time.time()
    
    # Processing each CSV file in the data folder
    for filename in os.listdir('data'):
        if filename.endswith('.csv'):
            filepath = os.path.join('data', filename)
            table_name = filename[:-4]  # removing .csv
            logging.info(f'Starting ingestion of {filename} into table {table_name}')
            
            try:
                # Reading the CSV in chunks to avoid loading entire file at once
                chunk_iter = pd.read_csv(filepath, chunksize=50000)  # adjusting chunk size as needed
                
                first_chunk = True
                for i, chunk in enumerate(chunk_iter):
                    # For the first chunk, replacing the table if it exists; otherwise append
                    if first_chunk:
                        ingest_db(chunk, table_name, engine, if_exists='replace')
                        first_chunk = False
                    else:
                        ingest_db(chunk, table_name, engine, if_exists='append')
                    
                    # Optional: log progress for large files
                    logger.debug(f'  Chunk {i+1} inserted for {filename}')
                
                logger.info(f'Successfully ingested {filename}')
            
            except Exception as e:
                logger.error(f'Failed to ingest {filename}: {str(e)}')
                # Continue to next file
    
    end = time.time()
    total_time = (end - start) / 60
    logger.info('---------------Ingestion Complete---------------')
    logger.info(f'Total Time Taken: {total_time:.2f} minutes')

if __name__ == '__main__':
    load_raw_data()



