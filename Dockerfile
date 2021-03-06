
FROM    alpine:3.3
MAINTAINER Daniel Nephin <dnephin@gmail.com>

ARG     MIRROR=http://apache.mirrors.pair.com/
ARG     VERSION=3.4.6
RUN     apk --update add openjdk7-jre wget bash
RUN     mkdir /opt && \
            wget -q -O - $MIRROR/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz | \
            tar -xzf - -C /opt && \
            mv /opt/zookeeper-$VERSION /opt/zookeeper && \
            cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg && \
            mkdir -p /tmp/zookeeper

ENV     JAVA_HOME /usr/lib/jvm/java-1.7-openjdk

EXPOSE  2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
