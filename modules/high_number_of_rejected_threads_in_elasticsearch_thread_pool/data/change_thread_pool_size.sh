

#!/bin/bash



# Set the new thread pool size

NEW_THREAD_POOL_SIZE=${NEW_THREAD_POOL_SIZE}



# Set the path to the Elasticsearch configuration file

ELASTICSEARCH_CONFIG_FILE=${ELASTICSEARCH_CONFIG_FILE_PATH}



# Replace the thread pool size in the configuration file

sed -i "s/thread_pool.size: .*/thread_pool.size: $NEW_THREAD_POOL_SIZE/g" $ELASTICSEARCH_CONFIG_FILE



# Restart Elasticsearch for the changes to take effect

systemctl restart elasticsearch