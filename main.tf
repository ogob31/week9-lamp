# Generates a secure private key and encodes it as PEM
resource "tls_private_key" "aws_lightsail_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create the Key Pair
resource "aws_lightsail_key_pair" "aws_lightsail_key_pair2" {
  name   = "lamp"
  public_key = tls_private_key.aws_lightsail_key_pair.public_key_openssh
}

# Save file
resource "local_file" "ssh_key" {
  filename = "lamp.pem"
  content  = tls_private_key.aws_lightsail_key_pair.private_key_pem
}
resource "aws_lightsail_instance" "server1" {
  name              = "lamp-server"
  blueprint_id      = "centos_stream_9"
  bundle_id         = "medium_1_0"
  availability_zone = "us-east-1a"

 key_pair_name = "lamp"
}