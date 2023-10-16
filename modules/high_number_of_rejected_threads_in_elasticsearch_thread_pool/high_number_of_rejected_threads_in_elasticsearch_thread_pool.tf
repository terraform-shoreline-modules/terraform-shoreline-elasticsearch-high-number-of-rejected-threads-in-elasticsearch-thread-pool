resource "shoreline_notebook" "high_number_of_rejected_threads_in_elasticsearch_thread_pool" {
  name       = "high_number_of_rejected_threads_in_elasticsearch_thread_pool"
  data       = file("${path.module}/data/high_number_of_rejected_threads_in_elasticsearch_thread_pool.json")
  depends_on = [shoreline_action.invoke_change_thread_pool_size]
}

resource "shoreline_file" "change_thread_pool_size" {
  name             = "change_thread_pool_size"
  input_file       = "${path.module}/data/change_thread_pool_size.sh"
  md5              = filemd5("${path.module}/data/change_thread_pool_size.sh")
  description      = "Increase the size of the thread pool to handle a higher number of concurrent threads. This can be done by adjusting the thread pool settings in the Elasticsearch configuration file."
  destination_path = "/tmp/change_thread_pool_size.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_change_thread_pool_size" {
  name        = "invoke_change_thread_pool_size"
  description = "Increase the size of the thread pool to handle a higher number of concurrent threads. This can be done by adjusting the thread pool settings in the Elasticsearch configuration file."
  command     = "`chmod +x /tmp/change_thread_pool_size.sh && /tmp/change_thread_pool_size.sh`"
  params      = ["NEW_THREAD_POOL_SIZE","ELASTICSEARCH_CONFIG_FILE_PATH"]
  file_deps   = ["change_thread_pool_size"]
  enabled     = true
  depends_on  = [shoreline_file.change_thread_pool_size]
}

