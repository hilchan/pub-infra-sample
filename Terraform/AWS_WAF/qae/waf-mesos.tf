resource "aws_waf_rule" "wafrule1" {
  depends_on  = ["aws_waf_ipset.superwhitelist2"]
  name        = "superwhitelist2"
  metric_name = "superwhitelist2"

  predicates {
    data_id = "${aws_waf_ipset.superwhitelist2.id}"
    negated = false
    type    = "IPMatch"
  }
}

// Do not use "-" on name.
resource "aws_waf_web_acl" "waf_acl" {
  depends_on  = ["aws_waf_ipset.superwhitelist2", "aws_waf_rule.wafrule1"]
  name        = "Brand${upper(var.environment)}2"
  metric_name = "Brand${upper(var.environment)}2"

  default_action {
      type = "BLOCK"
    }
    // Blacklist
    rules {
      action {
        type = "COUNT"
      }
      priority = 3
      rule_id  = "a49fef48-c3a1-4586-a053-fb3ec7212912"
    }
    // API-Block
    rules {
      action {
        type = "BLOCK"
      }
      priority = 5
      rule_id  = "02aaba14-98b7-4691-b62e-b4e255dd6969"
    }
    // Superwhitelist
    rules {
      action {
        type = "ALLOW"
      }
      priority = 7
      rule_id  = "${aws_waf_rule.wafrule1.id}"
    }
    // Badbots Block
    rules {
      action {
        type = "ALLOW"
      }
      priority = 8
      rule_id  = "38b0bd6a-b3f6-4f75-995a-ac538cb49625"
    }
    // IP Reputation Block #1
    rules {
      action {
        type = "ALLOW"
      }
      priority = 9
      rule_id  = "07a72e69-03f2-40f0-a7bb-c11682596761"
    }
    // IP Reputation Block #2
    rules {
      action {
        type = "ALLOW"
      }
      priority = 10
      rule_id  = "1a7a853a-3036-47f7-99c8-d6977236e4d1"
    }
    // XSS Block
    rules {
      action {
        type = "BLOCK"
      }
      priority = 11
      rule_id  = "ee623df2-4338-49e9-9ad8-fe8d953897c2"
    }
    // SQLi Blcok
    rules {
      action {
        type = "BLOCK"
      }
      priority = 12
      rule_id  = "d4db0faf-1084-4f3d-930f-a2728221a1b5"
    }
  }
