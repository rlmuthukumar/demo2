variable "vpc_id" {
  default     = "vpc-a37c4cdb"
  description = "AWS vpc id"
}
variable "subnet_id" {
  default     = "subnet-ce62cd84"
  description = "AWS subnet id"
}
variable "key_name" {
  default = "demo_key_pair"
}
variable "ami" {
  default     = "ami-0cf6f5c8a62fa5da6"
  description = "AMI ID"
}
variable "region" {
  default     = "us-west-2"
  description = "region"
}