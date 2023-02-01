resource "opentelekomcloud_compute_keypair_v2" "keypair" {
  count      = var.instance_count
  name       = "${var.project}-terraform_key"
  public_key = file(var.ssh_pub_key)
}