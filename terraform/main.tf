provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ml_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Choose an appropriate AMI for your region
  instance_type = "t2.micro"

  tags = {
    Name = "MLInstance"
  }
  
  key_name = "your-key-pair"  # Ensure you have a key pair for SSH access

  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.public_ip},' -u ec2-user --private-key your-key.pem setup.yml"
  }
}
