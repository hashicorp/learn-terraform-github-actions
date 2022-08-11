variable "some_string" {
 type = string
 default = "the quick brown fox jumps over lazy dog" # <- is a pangram, try others
}
locals {
 alphabet = "abcdefghijklmnopqrstuvwxyz"
 actual = "alphabet"
}

locals {
 pangram = length(local.actual) == 0
}
output "actual" {
 value = local.actual
}
output "pangram" {
 value = local.pangram
}
