resoruce "aws_subnet" "module" {
  vpc_id = "${vars.vpc_id}"
  cidr_block = "${vars.cidr_block}"
  availability_zone = "${vars.availability_zone}"
  tags {
    Name = "${vars.name}"
  }
}
