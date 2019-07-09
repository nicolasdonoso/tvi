provider "aws" {	
  profile    = "tvi"	
  region     = "us-east-1"	
}	

data "aws_route53_zone" "agenciaback-zone" {
  name = "agenciaback.com."
}

resource "aws_s3_bucket" "agenciaback-com" {	
  bucket = "${data.aws_route53_zone.ticketdale-zone.name}"	
  acl    = "public-read"	
  policy = "${file("policy.json")}"	

   website {	
    index_document = "index.html"	
    error_document = "error.html"	
  }	
}	

resource "aws_s3_bucket" "www-agenciaback-com" {	
  bucket = "www.${data.aws_route53_zone.ticketdale-zone.name}"	
  acl    = "public-read"	
  policy = "${file("policy-www.json")}"	

   website {	
    redirect_all_requests_to = "http://agenciaback.com"	
  }	
}
resource "aws_route53_record" "agenciaback" {
  zone_id = "${data.aws_route53_zone.agenciaback-zone.id}"
  name    = "${aws_s3_bucket.agenciaback-com.bucket}"
  type    = "A"
  alias {
    name = "${aws_s3_bucket.agenciaback-com.website_endpoint}"
    zone_id = "Z3AQBSTGFYJSTF"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.agenciaback-zone.id}"
  name    = "www"
  type    = "CNAME"
  ttl     = "5"
  records = ["${aws_s3_bucket.agenciaback-com.bucket}"]
}