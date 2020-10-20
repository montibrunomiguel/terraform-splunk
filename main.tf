#S3 Files

module "s3" {
  source = "/git_tfmodules/s3_private"
  repos = {
    master = {
      name = "cyberdefense-splunk-master-${var.environment}"
      versioning = true
      },
    itau-license = {
      name = "cyberdefense-splunk-license-${var.environment}"
      versioning = true
      },    
    search-head = {
      name = "cyberdefense-splunk-search-head-${var.environment}"
      versioning = true
      },    
    search-head-lambda = {
      name = "cyberdefense-splunk-search-head-lambda-${var.environment}"
      versioning = false
      }, 
     master-lambda = {
      name = "cyberdefense-splunk-master-lambda-${var.environment}"
      versioning = false
      }
    }
  }
