variable "key_name" {
    description = "Name of the SSH keypair to use in AWS."
}

variable "USER_NAME" {
    description = "Username to be used in the names of created resources."
}

variable "key_path" {
    description = "Path to the private portion of the SSH key specified."
    default = ""
}
variable "subnet_id" {
    description = "Which subnet id to create this in?"
    default = ""
}
variable "vpc_id" {
    description = "Which vpc id to create this in?"
    default = ""
}

variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "SERVER_SIZE" {}
variable "NUM_SERVERS" {}
variable "APP_NAME" {}
variable "ENV_NAME" {}

variable "aws_region" {
    description = "AWS region to launch Compute."
    default = "us-west-2"
}

variable "aws_amis" {
    description = "Image to be used in instance creation"
    default = "ami-f8768a80" 
	}
