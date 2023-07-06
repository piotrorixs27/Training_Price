import boto3
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Table_Price_Training_Terraform')
def lambda_handler(event, context):
      response=table.scan()
      return response["Items"]
      