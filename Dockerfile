FROM debian:stretch

RUN set -ex \
    && mkdir -p /uploads /etc/apt/sources.list.d /var/cache/apt/archives/ \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get clean \
    && apt-get update -y \
    && apt-get install -y \
        build-essential \
        openjdk-8-jre-headless \
        unzip \
        libhunspell-1.4-0 \
        hunspell-de-at \
        python-dev \
        python-numpy \
        python-scipy \
        libgomp1


RUN mkdir fastText 
WORKDIR /fastText

ENV FASTTEXT_VERSION 0.9.1

ADD https://dl.fbaipublicfiles.com/fasttext/supervised-models/lid.176.bin .
ADD https://github.com/facebookresearch/fastText/archive/v$FASTTEXT_VERSION.tar.gz fasttext.tar.gz
RUN tar xzf fasttext.tar.gz --strip-components=1 \
    && make

WORKDIR /

ENV VERSION 4.7
ADD https://www.languagetool.org/download/LanguageTool-$VERSION.zip /LanguageTool-$VERSION.zip

RUN unzip LanguageTool-$VERSION.zip \
    && rm LanguageTool-$VERSION.zip

WORKDIR /LanguageTool-$VERSION

ADD server.properties .

CMD ["java", "-cp", "languagetool-server.jar", "org.languagetool.server.HTTPServer", "--public", "--allow-origin", "*", "--config", "server.properties"]
EXPOSE 8081
