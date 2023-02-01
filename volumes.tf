resource "opentelekomcloud_blockstorage_volume_v2" "volume" {
  count = var.disk_size_gb > 0 ? var.instance_count : 0
  name  = "${var.project}-disk${format("%02d", count.index + 1)}"
  size  = var.disk_size_gb
  tags = {
    foo = "bar"
    key = "value"
  }
}