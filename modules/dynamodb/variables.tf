variable "dynamodb_table_name" {
  type = string
  description="Name of dynamodb table"
}
variable "billing_mode" {
  type=string
  validation{
    condition = var.billing_mode=="PAY_PER_REQUEST" ||  var.billing_mode=="PROVISIONED"
    error_message = "This is wrong mode."
  }
}
variable "table_class" {
type=string
validation {
  condition = var.table_class=="STANDARD" || var.table_class=="STANDARD_INFREQUENT_ACCESS"
  error_message = "This is wrong mode. Storage class of the table. Valid values are STANDARD and STANDARD_INFREQUENT_ACCESS"
}
}
variable "deletion_protection_enabled" {
  type = bool
  description = "Enables deletion protection for table."
    validation {
    condition=var.deletion_protection_enabled==false || var.deletion_protection_enabled==true
    error_message = "Enables deletion protection for table. Defaults to false."
  }
}
variable "hash_key" {
  type=string
  description = "Name of the hash key in the index; must be defined as an attribute in the resource."
}

variable "type_attribute_dynamodb" {
  type=string
}
variable "read_capacity" {
  default=1
  description = "Number of read units for this index."
}
variable "write_capacity" {
  default=1
  description = "Number of write units for this index."
}
