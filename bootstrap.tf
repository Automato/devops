resource "aws_s3_bucket" "automato_admin_log_bucket" {
  bucket = "automato-admin-log"
  acl = "log-delivery-write"

  tags {
    Name = "Automato administrative log bucket"
    Environment = "Internal"
  }
}

resource "aws_s3_bucket" "automato_admin_bucket" {
  bucket = "automato-admin"
  acl = "private"
  logging {
    target_bucket = "${aws_s3_bucket.automato_admin_log_bucket.id}"
    target_prefix = "log/"
  }
  versioning {
    enabled = true
  }

  tags {
    Name = "Automato administrative bucket"
    Environment = "Internal"
  }
}
