variable "os" {
  description = "Specify OS to use (linux/windows)"
  default = "linux"
}
variable "instance_type" {
  description = "Specify instance type to use"
  default = "t2.medium"
}
variable "instance_count" {
  description = "Specify how many instance to deploy"
  default = "1"
}
variable "tags" {
  type = "map"

  default = {
    Name = "sks-rke-hosts"
    Owner = "Sushant Sonker"
    Project = "OSS 2.0"
    Team = "DevOps Engineering"
  }
}