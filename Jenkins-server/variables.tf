variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "m7i-flex.large"
}

variable "key_name" {
  description = "Existing AWS key pair name"
}
