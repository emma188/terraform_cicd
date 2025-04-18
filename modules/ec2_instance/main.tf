
resource "aws_instance" "this" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [var.security_group]
  user_data     = var.user_data

  tags = {
    Name = "${var.instance_name}-${count.index + 1}"
  }
}
