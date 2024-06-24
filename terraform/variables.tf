variable "tld" {
  sensitive   = true
  type        = string
  description = "Top level domain"
}

variable "naked_domain" {
  sensitive   = true
  type        = string
  description = "Naked domain"
}

variable "sub_domain" {
  sensitive   = true
  type        = string
  description = "Sub domain"
  default     = "www"
}

variable "github_org" {
  type        = string
  description = "Github organization"
  default     = "Andresmup"
}

variable "repository_name" {
  type        = string
  description = "Repository name"
  default     = "portfolio"
}

variable "account_id" {
  sensitive   = true
  type        = string
  description = "Account id"
}

variable "protocol" {
  type        = string
  description = "Protocol used"
  default     = "https"
}