FROM gocd/gocd-agent-alpine-3.18:v23.5.0


ARG JDK_URL="https://github.com/AdoptOpenJDK/openjdk17-binaries/releases/download/jdk-2021-05-07-13-31/OpenJDK-jdk_x64_alpine-linux_hotspot_2021-05-06-23-30.tar.gz"

USER root

RUN apk add --no-cache wget \
    && wget -O /tmp/jdk.tar.gz $JDK_URL \
    && mkdir -p /opt/java \
    && tar -xzf /tmp/jdk.tar.gz -C /opt/java --strip-components=1 \
    && rm -f /tmp/jdk.tar.gz \
    && apk del --no-cache wget


ENV JAVA_HOME=/opt/java
ENV PATH=$PATH:$JAVA_HOME/bin

ENTRYPOINT ["/docker-entrypoint.sh"]

USER go