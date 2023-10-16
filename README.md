
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High Number of Rejected Threads in Elasticsearch Thread Pool
---

This incident type occurs when the Elasticsearch thread pool rejects a high number of threads. Thread pools are used to manage the number of concurrent threads that are executing in an application. When a thread pool becomes overwhelmed, it may start rejecting new threads, leading to a high number of rejected threads. This can cause performance issues and impact the availability of the Elasticsearch cluster. It is important to investigate the root cause of this incident and take necessary actions to prevent it from happening in the future.

### Parameters
```shell
export ELASTICSEARCH_PORT="PLACEHOLDER"

export ELASTICSEARCH_HOST="PLACEHOLDER"

export ELASTICSEARCH_LOG_FILE_PATH="PLACEHOLDER"

export PROCESS_NAME="PLACEHOLDER"

export ELASTICSEARCH_PID="PLACEHOLDER"

export NEW_THREAD_POOL_SIZE="PLACEHOLDER"

export ELASTICSEARCH_CONFIG_FILE_PATH="PLACEHOLDER"
```

## Debug

### Check Elasticsearch thread pool rejection count
```shell
curl -XGET '${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_cat/thread_pool?v&h=name,rejected'
```

### Check Elasticsearch thread pool size and queue capacity
```shell
curl -XGET '${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}/_nodes/stats/thread_pool?pretty'
```

### Check Elasticsearch logs for any errors related to thread pool rejection
```shell
grep 'rejected execution' ${ELASTICSEARCH_LOG_FILE_PATH}
```

### Check the number of available threads in the system
```shell
cat /proc/sys/kernel/threads-max
```

### Check the maximum number of threads allowed per process
```shell
ulimit -u
```

### Check the current number of threads per process
```shell
ps -eo nlwp,pid,cmd | grep ${PROCESS_NAME}
```

### Check the system load
```shell
uptime
```

### Check the CPU usage of Elasticsearch process
```shell
top -p ${ELASTICSEARCH_PID}
```

## Repair

### Increase the size of the thread pool to handle a higher number of concurrent threads. This can be done by adjusting the thread pool settings in the Elasticsearch configuration file.
```shell


#!/bin/bash



# Set the new thread pool size

NEW_THREAD_POOL_SIZE=${NEW_THREAD_POOL_SIZE}



# Set the path to the Elasticsearch configuration file

ELASTICSEARCH_CONFIG_FILE=${ELASTICSEARCH_CONFIG_FILE_PATH}



# Replace the thread pool size in the configuration file

sed -i "s/thread_pool.size: .*/thread_pool.size: $NEW_THREAD_POOL_SIZE/g" $ELASTICSEARCH_CONFIG_FILE



# Restart Elasticsearch for the changes to take effect

systemctl restart elasticsearch


```