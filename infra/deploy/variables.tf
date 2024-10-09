variable "prefix" {
    description = "presfix for resources in aws"
    default = "gen-ai"
}
variable "project" {
    description = "project name for tagging resources in aws"
    default = "tf-phi3-gen-ai-project"
}
variable "contact" {
    description = "contact email for tagging resources in aws"
    default = "m.osama.elmoghany@gmail.com"
}
variable "region" {
  description = "region name for tagging resources"
  default = "us-east-1"
}