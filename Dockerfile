FROM qnib/alplain-openjre8

ARG KAFKA_VER=0.10.1.1
ARG API_VER=2.12
ENV KAFKA_PORT=9092 \
    ENTRYPOINTS_DIR=/opt/qnib/entry \
    ZK_SERVERS=tasks.zookeeper:2181 \
    KAFKA_BROKER_ID=0 \
    ADVERTISED_LISTENERS=kafka_broker \
    INTER_BROKER_PROTOCOL_VERSION=0.10.1-IV2 \
    LOG_MESSAGE_FORMAT_VERSION=0.10.1-IV2 \
    KAFKA_ID_OFFSET=0
RUN apk --no-cache add curl \
 && curl -fLs http://apache.mirrors.pair.com/kafka/${KAFKA_VER}/kafka_${API_VER}-${KAFKA_VER}.tgz | tar xzf - -C /opt \
 && mv /opt/kafka_${API_VER}-${KAFKA_VER} /opt/kafka/ \
 && apk --no-cache del curl
COPY opt/qnib/entry/20-kafka.sh /opt/qnib/entry/
COPY opt/qnib/kafka/bin/start.sh /opt/qnib/kafka/bin/
COPY opt/qnib/kafka/conf/server.properties /opt/qnib/kafka/conf/
HEALTHCHECK --interval=2s --retries=15 --timeout=1s \
    CMD netstat -plnt |grep 9092
CMD ["/opt/qnib/kafka/bin/start.sh"]
