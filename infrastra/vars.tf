variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-072d6c9fae3253f26"
  }
}

variable "vpc-name" {
  type    = string
  default = "wp"
}

variable "availability-zone" {
  type    = string
  default = "us-east-1a"
}
