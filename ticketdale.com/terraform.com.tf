provider "aws" {	
  profile    = "tvi"	
  region     = "us-east-1"	
}	

data "aws_route53_zone" "ticketdale-zone" {
  name = "ticketdale.com."
}

resource "aws_s3_bucket" "ticketdale-com" {	
  bucket = "ticketdale.com"	
  acl    = "public-read"	
  policy = "${file("policy.json")}"	

   website {	
    index_document = "index.html"	
    error_document = "error.html"	
  }	
}	

resource "aws_s3_bucket" "www-ticketdale-com" {	
  bucket = "www.ticketdale.com"	
  acl    = "public-read"	
  policy = "${file("policy-www.json")}"	

   website {	
    redirect_all_requests_to = "http://ticketdale.com"	
  }	
}
resource "aws_route53_record" "ticketdale" {
  zone_id = "${data.aws_route53_zone.ticketdale-zone.id}"
  name    = "${aws_s3_bucket.ticketdale-com.bucket}."
  type    = "A"
  alias {
    name = "${aws_s3_bucket.ticketdale-com.website_endpoint}"
    zone_id = "Z3AQBSTGFYJSTF"
    evaluate_target_health = false
  }
}