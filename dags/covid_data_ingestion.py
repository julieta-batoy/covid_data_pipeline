# Import necessary libraries and modules
import os
import pandas as pd
import requests
from io import StringIO
from sqlalchemy import create_engine
from dagster import job, op

BASE_URL = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports_us/'
STAGING_DB = os.getenv('STAGING_DB')

# Define an operation to download and merge CSV files into a single DataFrame
@op
def download_csv_files():
    response = requests.get('https://api.github.com/repos/CSSEGISandData/COVID-19/contents/csse_covid_19_data/csse_covid_19_daily_reports_us')
    files = response.json()
    data_frames = []
    
    for file_info in files:
        if file_info['name'].endswith('.csv'):
            file_url = file_info['download_url']
            file_content = requests.get(file_url).content.decode('utf-8')
            df = pd.read_csv(StringIO(file_content))
            data_frames.append(df)
    
    merged_df = pd.concat(data_frames, ignore_index=True)
    return merged_df

# Define an operation to load the merged data into the staging table in the database
@op
def load_to_staging(df):
    engine = create_engine(STAGING_DB)
    df.to_sql('covid_staging', engine, if_exists='replace', index=False)

# Define the job to orchestrate the data ingestion process
@job
def covid_data_ingestion():
    df = download_csv_files()
    load_to_staging(df)
