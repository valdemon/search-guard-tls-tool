FROM openjdk:8-jre-alpine

LABEL maintainer="Waldek Kozba <100assc@gmail.com>"
LABEL description="Search Guard TLS Tool"

ENV ES_TMPDIR "/tmp"
ENV VERSION 1.6
ENV TARBAL "https://search.maven.org/remotecontent?filepath=com/floragunn/search-guard-tlstool/${VERSION}/search-guard-tlstool-${VERSION}.tar.gz"
ENV TARBALL_ASC "${TARBAL}.asc"
ENV GPG_KEY "4A61C8AE"
ENV GPG_KEYSERVER "keys2.kfwebs.net"
ENV PATH /tlstool/tools:$PATH

# Install Elasticsearch.
RUN apk add --no-cache --update bash ca-certificates su-exec util-linux curl openssl rsync
RUN apk add --no-cache -t .build-deps gnupg \
  && mkdir /tlstool \
  && cd /tlstool \
  && echo "===> Install Search Guard TLS Tool..." \
  && curl -o search-guard-tls-tool.tar.gz -Lskj "$TARBAL"; \
  if [ "$TARBALL_ASC" ]; then \
    curl -o search-guard-tls-tool.tar.gz.asc -Lskj "$TARBALL_ASC"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --keyserver $GPG_KEYSERVER --recv-keys "$GPG_KEY"; \
    gpg --batch --verify search-guard-tls-tool.tar.gz.asc search-guard-tls-tool.tar.gz; \
    rm -r "$GNUPGHOME" search-guard-tls-tool.tar.gz.asc; \
  fi; \
  tar -xf search-guard-tls-tool.tar.gz \
  && ls -lah
  
ENTRYPOINT ["/tlstool/tools/sgtlstool.sh"]