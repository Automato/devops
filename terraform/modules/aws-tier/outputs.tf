output "vpc_id" {
  value = "${aws_vpc.tier.id}"
}

output "external_subnet_ids" {
  value = ["${aws_subnet.external.*.id}"]
}

output "external_db_subnet_ids" {
  value = ["${aws_subnet.external_db.*.id}"]
}

output "internal_subnet_ids" {
  value = ["${aws_subnet.internal.*.id}"]
}

output "internal_db_subnet_ids" {
  value = ["${aws_subnet.internal_db.*.id}"]
}

