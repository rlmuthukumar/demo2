resource "aws_instance" "teleport" {
  ami = var.ami
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [ aws_security_group.tele-sg.id ]
  subnet_id = var.subnet_id
  }
resource "aws_eip" "lb" {
  instance = aws_instance.teleport.id
  vpc      = true
}
resource "aws_route53_record" "www-live" {
  zone_id = ""
  name = "teleport.it-qa.chargepoint.com"
  type = "CNAME"
  ttl = "300"
  records = ["chargepoint.com"]
}


