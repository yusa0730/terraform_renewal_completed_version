variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "tc-ishizawa"
}

variable "env" {
  description = "The environment (e.g. dev, prod)."
  type        = string
  default     = "stg"
}

variable "region" {
  description = "The AWS region."
  type        = string
  default     = "ap-northeast-1"
}

variable "subnets" {
  description = "List of subnets"
  type = list(object({
    cidr_block        = string
    availability_zone = string
    name_suffix       = string
  }))
  default = [
    { cidr_block = "11.2.6.0/24", availability_zone = "a", name_suffix = "protected1" },
    { cidr_block = "11.2.7.0/24", availability_zone = "c", name_suffix = "protected2" },
    { cidr_block = "11.2.8.0/24", availability_zone = "a", name_suffix = "protected3" },
    { cidr_block = "11.2.9.0/24", availability_zone = "c", name_suffix = "protected4" },
    { cidr_block = "11.2.10.0/24", availability_zone = "a", name_suffix = "protected5" },
    { cidr_block = "11.2.11.0/24", availability_zone = "c", name_suffix = "protected6" },
    { cidr_block = "11.2.12.0/24", availability_zone = "a", name_suffix = "protected7" },
    { cidr_block = "11.2.13.0/24", availability_zone = "c", name_suffix = "protected8" },
    { cidr_block = "11.2.14.0/24", availability_zone = "a", name_suffix = "protected9" },
    { cidr_block = "11.2.15.0/24", availability_zone = "c", name_suffix = "protected10" },
    { cidr_block = "11.2.16.0/24", availability_zone = "a", name_suffix = "protected11" },
    { cidr_block = "11.2.17.0/24", availability_zone = "c", name_suffix = "protected12" },
    { cidr_block = "11.2.18.0/24", availability_zone = "a", name_suffix = "protected13" },
    { cidr_block = "11.2.19.0/24", availability_zone = "c", name_suffix = "protected14" },
    { cidr_block = "11.2.20.0/24", availability_zone = "a", name_suffix = "protected15" },
    { cidr_block = "11.2.21.0/24", availability_zone = "c", name_suffix = "protected16" },
    { cidr_block = "11.2.22.0/24", availability_zone = "a", name_suffix = "protected17" },
    { cidr_block = "11.2.23.0/24", availability_zone = "c", name_suffix = "protected18" },
    { cidr_block = "11.2.2.0/24", availability_zone = "a", name_suffix = "protected19" },
    { cidr_block = "11.2.3.0/24", availability_zone = "c", name_suffix = "protected20" }
  ]
}
