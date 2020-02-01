FROM openjdk:8
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends net-tools curl netcat

ENV HBASE_VERSION 1.3.6

# Updated endpoint as it changes for 1.3.6 version
# See http://www.apache.org/dist/hbase/
ENV HBASE_URL http://www.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz
RUN set -x \
    && curl -fSL "$HBASE_URL" -o /tmp/hbase.tar.gz \
    && curl -fSL "$HBASE_URL.asc" -o /tmp/hbase.tar.gz.asc \
    && tar -xvf /tmp/hbase.tar.gz -C /opt/ \
    && rm /tmp/hbase.tar.gz*

RUN ln -s /opt/hbase-$HBASE_VERSION/conf /etc/hbase
RUN mkdir /opt/hbase-$HBASE_VERSION/logs

RUN mkdir /hadoop-data

ENV HBASE_PREFIX=/opt/hbase-$HBASE_VERSION
ENV HBASE_CONF_DIR=/etc/hbase

ENV PHOENIX_VERSION=4.14.3
ENV PHOENIX_SERVER phoenix-server-$PHOENIX_VERSION-HBase-1.3.jar
RUN curl -fSL https://repo1.maven.org/maven2/org/apache/phoenix/phoenix-server/$PHOENIX_VERSION-HBase-1.3/$PHOENIX_SERVER -o $HBASE_PREFIX/lib/$PHOENIX_SERVER

ENV USER=root
ENV PATH $HBASE_PREFIX/bin/:$PATH

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
