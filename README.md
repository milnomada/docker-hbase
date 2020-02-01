# docker-hbase-phoenix

Docker version for Hbase [1.3.6]() cluster on hadoop 2.7.4  
This version includes Phoenix [4.14.3](https://mvnrepository.com/artifact/org.apache.phoenix/phoenix-server/4.14.3-HBase-1.3) connected to Zookeeper 3.4.10  
Forked from this [docker-hbase](https://github.com/big-data-europe/docker-hbase) repo  

It allows to query HBase using the [python-phoenixdb](https://python-phoenixdb.readthedocs.io/en/latest/) driver
to easily send SQL queries to the HBase cluster.  

HDFS [Arch](https://hadoop.apache.org/docs/r1.2.1/hdfs_design.html)
Hbase [Architecture](https://mapr.com/blog/in-depth-look-hbase-architecture/)

Python Phoenix [Driver](https://phoenix.apache.org/python.html)  
HBase [reference](http://hbase.apache.org/book.html)  

HBase Region Server [Image](https://hub.docker.com/r/bde2020/hbase-regionserver/dockerfile)  
HBase Master Server [Image](https://hub.docker.com/r/bde2020/hbase-master/dockerfile)  
Docker Apache Phonix [Repo](https://github.com/smizy/docker-apache-phoenix) (To use with Python)
Zookeer Docker Image [configuration flags](https://hub.docker.com/_/zookeeper)  

# Standalone

This configuration has **no support** for Phoenix  

To run standalone hbase:
```bash
docker-compose -f docker-compose-standalone.yml up -d
```
The deployment is the same as in [quickstart HBase documentation](https://hbase.apache.org/book.html#quickstart).
Can be used for testing/development, connected to Hadoop cluster.

# Local distributed
To run local distributed hbase with phoenix:

## Requisites

Build the base version of Hbase 1.3.6  
This image will serve to launch hbase-master and hbase-regionserver containers  
```bash
cd base
docker build -t hbase-1.3.6 .
```

Once the base HBase image is built, proceed to create master and regionserver images:
```bash
cd hmaster
docker build -t hbase-master-1.3.6 .

cd ../hregionserver
docker build -t hbase-regionserver-1.3.6 .
```

```bash
docker-compose -f docker-compose-distributed-local-with-phoenix.yml up -d
```

This deployment will start Zookeeper, HMaster and HRegionserver in separate containers.

# Distributed
To run distributed hbase on docker swarm see this [doc](./distributed/README.md)


# Zeppelin

https://zeppelin.apache.org/docs/0.6.2/interpreter/jdbc.html#phoenix


# Troubleshooting

In case to find connection issues among your instances, have a look at:  

https://community.cloudera.com/t5/Support-Questions/Phoenix-and-HBase-connection/td-p/183238  
http://apache-phoenix-user-list.1124778.n5.nabble.com/Re-error-when-using-apache-phoenix-4-14-0-HBase-1-2-bin-with-hbase-1-2-6-td4698.html  
https://issues.apache.org/jira/browse/PHOENIX-1473  
https://community.cloudera.com/t5/Support-Questions/Hbase-Connectivity-Fails/td-p/95088  
