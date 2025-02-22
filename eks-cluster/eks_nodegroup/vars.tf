variable "allow_ip" {
  default = ["0.0.0.0/0"]
}

variable "environment" {
  default = "poc"
}

variable "SOURCE_GMAIL_ID"{
  description = "Source GMAIl Id"
  default =""
}
variable "SOURCE_AUTH_PASSWORD"{
  description = "Source Auth Password"
  default =""
}
variable "DESTINATION_GMAIL_ID"{
  description = "Destinal GMAIl Id"
  default =""
}