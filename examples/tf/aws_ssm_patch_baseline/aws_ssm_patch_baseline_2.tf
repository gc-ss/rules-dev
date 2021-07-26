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