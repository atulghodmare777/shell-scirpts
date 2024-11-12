# Write a Python script using boto3 to list all S3 buckets in an AWS account and their respective sizes.
import boto3
from botocore.exceptions import NoCredentialsError, PartialCredentialsError
import sys

# Initialize boto3 S3 client
s3 = boto3.client('s3')

def get_bucket_size(bucket_name):
    """
    Calculates the total size of all objects in the specified S3 bucket.
    """
    total_size = 0
    try:
        # Using paginator to handle large numbers of objects
        paginator = s3.get_paginator('list_objects_v2')
        for page in paginator.paginate(Bucket=bucket_name):
            if 'Contents' in page:
                for obj in page['Contents']:
                    total_size += obj['Size']
    except Exception as e:
        print(f"Error fetching size for bucket {bucket_name}: {e}")
    return total_size

def list_buckets_with_sizes():
    """
    Lists all S3 buckets and their respective sizes.
    """
    try:
        buckets = s3.list_buckets()['Buckets']
        print("S3 Buckets and their Sizes:")
        for bucket in buckets:
            bucket_name = bucket['Name']
            bucket_size = get_bucket_size(bucket_name)
            size_in_mb = bucket_size / (1024 * 1024)
            print(f"Bucket: {bucket_name}, Size: {size_in_mb:.2f} MB")
    except (NoCredentialsError, PartialCredentialsError):
        print("AWS credentials not found. Please configure your credentials.")
    except Exception as e:
        print(f"Error listing buckets: {e}")
        sys.exit(1)

if __name__ == "__main__":
    list_buckets_with_sizes()
