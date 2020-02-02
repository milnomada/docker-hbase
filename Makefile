DOCKER_NETWORK = hbase
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
hadoop_branch := 2.0.0-hadoop2.7.4-java8
hbase_version := 1.3.6
phoenix_version := 4.14.3

.PHONY: build standalone wordcount

build:
	docker build -t hbase-$(hbase_version) ./base
	docker build -t hbase-master-$(hbase_version) ./hmaster
	docker build -t hbase-regionserver-$(hbase_version): ./hregionserver
	docker build -t phoenix-$(phoenix_version) ./phoenix

standalone:
	docker build -t bde2020/hbase-standalone:$(current_branch) ./standalone

wordcount:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(hadoop_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(hadoop_branch) hdfs dfs -copyFromLocal -f /opt/hadoop-2.7.4/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(hadoop_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(hadoop_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(hadoop_branch) hdfs dfs -rm -r /input
