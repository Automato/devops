output "tier_vpc_id" {
  value = "${aws_vpc.tier.id}"
}

output "external_subnet_ids" {
  value = ["${aws_subnet.external.*.id}"]
}
