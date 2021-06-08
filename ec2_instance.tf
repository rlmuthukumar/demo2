resource "aws_instance" "teleport" {
    ami                         = var.ami
//  ami                         = "ami-0cf6f5c8a62fa5da6"
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = false
  user_data                   = file("apache-install.sh")
  //  user_data              = <<-EOF
  //    #!/bin/bash
  //    sudo yum update -y
  //    sudo yum install httpd -y
  //    sudo systemctl start httpd
  //    sudo systemctl enable httpd
  //    echo "<h1>Welcome to StackSimplify ! AWS Infra created using Terraform in us-east-1 Region</h1>" > /var/www/html/index.html
  //    EOF
  vpc_security_group_ids = [aws_security_group.tele-sg.id]
  tags = {
    Name = "teleport"
  }

}

resource "aws_eip" "lb" {
  instance = aws_instance.teleport.id
  vpc      = true
}
// resource "aws_route53_record" "www-live" {
//   zone_id = ""
//   name = "teleport.it-qa.chargepoint.com"
//   type = "CNAME"
//   ttl = "300"
//   records = ["chargepoint.com"]
// }


