

#---- 0 ----

resource "aws_ssm_patch_baseline" "production" {
  name             = "patch-baseline"
  approved_patches = ["KB123456"]
}

#---- 1 ----

resource "aws_ssm_patch_baseline" "production" {
  name             = "patch-baseline"
  description      = "Patch Baseline Description"
  approved_patches = ["KB123456", "KB456789"]
  rejected_patches = ["KB987654"]

  global_filter {
    key    = "PRODUCT"
    values = ["WindowsServer2008"]
  }

  global_filter {
    key    = "CLASSIFICATION"
    values = ["ServicePacks"]
  }

  global_filter {
    key    = "MSRC_SEVERITY"
    values = ["Low"]
  }

  approval_rule {
    approve_after_days = 7
    compliance_level   = "HIGH"

    patch_filter {
      key    = "PRODUCT"
      values = ["WindowsServer2016"]
    }

    patch_filter {
      key    = "CLASSIFICATION"
      values = ["CriticalUpdates", "SecurityUpdates", "Updates"]
    }

    patch_filter {
      key    = "MSRC_SEVERITY"
      values = ["Critical", "Important", "Moderate"]
    }
  }

  approval_rule {
    approve_after_days = 7

    patch_filter {
      key    = "PRODUCT"
      values = ["WindowsServer2012"]
    }
  }
}

#---- 2 ----

resource "aws_ssm_patch_baseline" "windows_os_apps" {
  name             = "WindowsOSAndMicrosoftApps"
  description      = "Patch both Windows and Microsoft apps"
  operating_system = "WINDOWS"

  approval_rule {
    approve_after_days = 7

    patch_filter {
      key    = "CLASSIFICATION"
      values = ["CriticalUpdates", "SecurityUpdates"]
    }

    patch_filter {
      key    = "MSRC_SEVERITY"
      values = ["Critical", "Important"]
    }
  }

  approval_rule {
    approve_after_days = 7

    patch_filter {
      key    = "PATCH_SET"
      values = ["APPLICATION"]
    }

    # Filter on Microsoft product if necessary 
    patch_filter {
      key    = "PRODUCT"
      values = ["Office 2013", "Office 2016"]
    }
  }
}

#---- 3 ----

resource "aws_ssm_patch_baseline" "production" {
  name             = "patch-baseline"
  approved_patches = ["KB123456"]
}

resource "aws_ssm_patch_group" "patchgroup" {
  baseline_id = "${aws_ssm_patch_baseline.production.id}"
  patch_group = "patch-group-name"
}