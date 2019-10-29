# Configure the AWS Provider
provider "aws" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "~> 2.7"
  region = "us-east-2"
  access_key=""
  secret_key=""
}


variable "filename_lookup" {
  type = "map"

  default = {

    windows = "windows_userdata.tpl"
    linux   = "linux_userdata.tpl"
  }
}


data "template_file" "userdata" {
  template = "${file("${path.module}/templates/${var.filename_lookup["${var.os}"]}")}"

  vars = {
    rancher_message = "Rancher manager setup with userdata as template"
  }
}


# Places instances in first subnet 
resource "aws_instance" "rancher-manager" {
  ami                    = "ami-01a834fd83ae239ff" 
  instance_type          = "${var.instance_type}"
  key_name               = "jenkins.pem"
  count                  = "${var.instance_count}"
  vpc_security_group_ids = ["sg-03bc795c15f28ee72"]
  subnet_id              = "subnet-7e74af16"
  user_data              = "${data.template_file.userdata.rendered}"

  tags = "${var.tags}"
}
