provider "aws" {	
  profile    = "tvi"	
  region     = "us-east-1"	
}	

 resource "aws_s3_bucket" "ticketdale.com" {	
  bucket = "ticketdale.com"	
  acl    = "public-read"	
  policy = "${file("policy.json")}"	

   website {	
    index_document = "index.html"	
    error_document = "error.html"	
  }	
}	

 resource "aws_s3_bucket" "www.ticketdale.com" {	
  bucket = "www.ticketdale.com"	
  acl    = "public-read"	
  policy = "${file("policy-www.json")}"	

   website {	
    redirect_all_requests_to = "http://ticketdale.com"	
  }	
}