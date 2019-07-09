provider "aws" {	
  profile    = "tvi"	
  region     = "us-east-1"	
}	

 resource "aws_s3_bucket" "a" {	
  bucket = "agenciaback.com"	
  acl    = "public-read"	
  policy = "${file("policy.json")}"	

   website {	
    index_document = "index.html"	
    error_document = "error.html"	
  }	
}	

 resource "aws_s3_bucket" "b" {	
  bucket = "www.agenciaback.com"	
  acl    = "public-read"	
  policy = "${file("policy-www.json")}"	

   website {	
    redirect_all_requests_to = "http://agenciasback.com"	
  }	
}