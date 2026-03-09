variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "t4g.xlarge"
}

variable "key_name" {
  description = "Existing AWS key pair name"
}
