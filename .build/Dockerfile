FROM eclipse-temurin:17.0.7_7-jre-alpine
RUN apk add wget jq bash
RUN rm -rf /var/cache/apk/*
# replace the container and install commands with ones for your architecture
# make sure you have wget, jq, and bash avaliable

# install geyser
WORKDIR /data
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]