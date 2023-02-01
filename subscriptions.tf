resource "opentelekomcloud_smn_topic_v2" "topic" {
  name         = "${var.project}-topic"
  display_name = "The display name of ${var.project}-topic"
}

resource "opentelekomcloud_smn_subscription_v2" "subscription_1" {
  topic_urn = opentelekomcloud_smn_topic_v2.topic.id
  endpoint  = var.endpoint_email
  protocol  = "email"
  remark    = "O&M"
}

resource "opentelekomcloud_smn_subscription_v2" "subscription_2" {
  topic_urn = opentelekomcloud_smn_topic_v2.topic.id
  endpoint  = var.endpoint_sms
  protocol  = "sms"
  remark    = "O&M"
}