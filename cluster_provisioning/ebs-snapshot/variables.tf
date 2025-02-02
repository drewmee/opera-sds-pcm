variable "project" {
  default = "opera"
}

variable "venue" {
  default = "int"
}

variable "profile" {
  default = "saml"
  #int
  #default = "saml-pub"
}

variable "verdi_release" {
  default = "v4.0.1-beta.2"
}

variable "registry_release" {
  default = "2"
}

variable "logstash_release" {
  default = "7.9.3"
}

variable "pge_snapshots_date" {
  default = "20210805-R2.0.0"
}

variable "opera_pge_release" {
  default = "R2.0.0"
}

variable "private_key_file" {
   #int
   #default="~/.ssh/operasds-int-cluster-1.pem"
}

variable "keypair_name" {
  default = "operasds-int-cluster-1"
}

variable "shared_credentials_file" {
  default = "~/.aws/credentials"
}

variable "az" {
  default = "us-west-2a"
}

variable "region" {
  default = "us-west-2"
}

variable "verdi_security_group_id" {
  default = "sg-05c2b46227bb3bf54"
}

variable "pcm_verdi_role" {
  default = {
    name = "am-pcm-dev-verdi-role"
    path = "/"
  }
}

variable "verdi" {
  type = map(string)
  default = {
    name               = "verdi"
    ami                = "ami-00baa2004b03f6090"
    instance_type      = "t3.medium"
    device_name        = "/dev/sda1"
    device_size        = 50
    docker_device_name = "/dev/sdf"
    docker_device_size = 25
    private_ip         = ""
    public_ip          = ""
  }
}

variable "asg_use_role" {
  default = "true"
}

variable "asg_vpc" {
  default = "vpc-b5a983cd"
}

variable "subnet_id" {
  default = "subnet-8ecc5dd3"
}

variable "artifactory_base_url" {
  default = "https://cae-artifactory.jpl.nasa.gov/artifactory"
}

variable "artifactory_repo" {
  default = "general-develop"
}

variable "artifactory_mirror_url" {
  default = "s3://opera-dev/artifactory_mirror"
}

variable "docker_user" {
  default = ""
}

variable "docker_pwd" {
  default = ""
}

variable "use_s3_uri_structure" {
  default = true
}
