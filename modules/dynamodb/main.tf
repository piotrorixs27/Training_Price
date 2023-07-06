resource "aws_dynamodb_table" "Table_Price_Training" {
  name                        = var.dynamodb_table_name
  billing_mode                = var.billing_mode
  table_class                 = var.table_class
  deletion_protection_enabled = var.deletion_protection_enabled
  hash_key                    = var.hash_key
  attribute {
    name = var.name_currency
    type = var.type_attribute_dynamodb
  }
}
resource "aws_dynamodb_table_item" "DynamoDb_Base_EUR" {
  table_name = aws_dynamodb_table.Table_Price_Training.name
  hash_key   = aws_dynamodb_table.Table_Price_Training.hash_key
  for_each = {
    EUR = 13
    CHF = 25
    ZL  = 100
    USD = 30
    GBP = 25
  }
  item = <<ITEM
{

  "currency": {"S":"${each.key}"},
  "price": {"N": "${each.value}"}
}
ITEM
}

