FROM ruby:2.5.3

RUN apt-get update && apt-get install -qq -y --no-install-recommends build-essential

RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh && bash nodesource_setup.sh && rm nodesource_setup.sh

RUN apt-get install -y nodejs

RUN gem update bundler

RUN npm i -g yarn

# Setup App
RUN mkdir -p /jarvis
WORKDIR /jarvis
COPY . .

COPY ./docker/app/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

ENV BUNDLE_PATH=/bundle \
BUNDLE_BIN=/bundle/bin \
GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"