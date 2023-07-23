import logging
from typing import List
import azure.functions as func
from azure.storage.blob import BlobServiceClient, BlobClient

storage_connection_string = "DefaultEndpointsProtocol=https;AccountName=motadatastorage2307;AccountKey=WARuwjpr8qshXX+Wtq1kP0XSmyPP9dEL8n5MRGkTCJ8Kn5cBQSjQ5jyjxKGZSpR26k6NtuaEquuM+AStFJVk4g==;EndpointSuffix=core.windows.net"
container_name = "motadata-logs"
blob_name = "motadata.json"

logging.info('1Python EventHub trigger function processed an event.')

def main(events: List[func.EventHubEvent]):
    logging.info('2Python inside main EventHub trigger function processed an event.')
    blob_service_client = BlobServiceClient.from_connection_string(conn_str=storage_connection_string)

    for event in events:
        logging.info('3Python container  client.')
        event_data = event.get_body().decode('utf-8')
        logging.info('4Python EventHub trigger processed an event: %s', event_data)
        
        
        blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)
        logging.info('Blob  client.')
        if blob_client.exists():
            logging.info('File exists. Updating file.')
            existing_data = blob_client.download_blob().readall().decode('utf-8')
            logging.info('6Python EventHub trigger processed an event: %s', existing_data)
            updated_data = existing_data + "\n" + event_data
        else:
            logging.info('File does not exist. Creating file.')
            updated_data = event_data
        
        blob_client.upload_blob(updated_data, overwrite=True)
        logging.info('7Python EventHub Completed uploading event data to storage account')        

logging.info('8Python EventHub Completed uploading event data to storage account')