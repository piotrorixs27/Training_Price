import boto3
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Table_Price_Training_Terraform')
def lambda_handler(event, context):
      print(event)
      print(event["rawPath"][1:])
      print(context)
      currency=event["rawPath"][1:]
      response=table.get_item(
       Key={
        'currency': currency
    },
       
      )
      return response["Item"]


            