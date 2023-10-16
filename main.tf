terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "high_number_of_rejected_threads_in_elasticsearch_thread_pool" {
  source    = "./modules/high_number_of_rejected_threads_in_elasticsearch_thread_pool"

  providers = {
    shoreline = shoreline
  }
}