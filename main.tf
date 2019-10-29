# Configure the AWS Provider
provider "aws" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "~> 2.7"
  region = "us-east-1"
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

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-925b0fe8"]
  }

  owners = ["679593333241"] # Canonical
}



# Places instances in first subnet 
resource "aws_instance" "rancher-manager" {
  ami                    = "${data.aws_ami.centos.id}" 
  instance_type          = "${var.instance_type}"
  key_name               = "upworks_manoj"
  count                  = "${var.instance_count}"
  vpc_security_group_ids = ["sg-09013457588c0afde"]
  subnet_id              = "subnet-0671b05a"
  user_data              = "${data.template_file.userdata.rendered}"

  tags = "${var.tags}"
}
