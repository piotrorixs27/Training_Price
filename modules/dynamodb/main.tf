resource "aws_dynamodb_table" "Table_Price_Training" {
  name                        = var.dynamodb_table_name
  billing_mode                = var.billing_mode
  read_capacity=var.billing_mode=="PAY_PER_REQUEST"?null:var.read_capacity
  write_capacity=var.billing_mode=="PAY_PER_REQUEST"?null:var.write_capacity

  table_class                 = var.table_class
  deletion_protection_enabled = var.deletion_protection_enabled
  hash_key                    = var.hash_key
  attribute {
    name = var.hash_key
    type = local.possible_types[var.type_attribute_dynamodb]
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

