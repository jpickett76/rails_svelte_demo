# Date: 2023-01-01 You may wish change the ruby version depending upon what you are using. For instance, at the time
# of this writing, the latest version of ruby available to rbenv users is 3.1.2. You can check for what versions are available for Docker here
#https://hub.docker.com/_/ruby
FROM ruby:3.1.2-alpine

RUN apk add git

RUN apk add --update build-base bash bash-completion libffi-dev tzdata postgresql-client postgresql-dev nodejs npm yarn

RUN yarn add svelte esbuild-svelte

WORKDIR /app

COPY Gemfile* /app/

RUN gem install bundler

RUN bundle install

RUN bundle binstubs --all

RUN touch $HOME/.bashrc

RUN echo "alias ll='ls -alF'" >> $HOME/.bashrc
RUN echo "alias la='ls -A'" >> $HOME/.bashrc
RUN echo "alias l='ls -CF'" >> $HOME/.bashrc
RUN echo "alias q='exit'" >> $HOME/.bashrc
RUN echo "alias c='clear'" >> $HOME/.bashrc

CMD [ "/bin/bash" ]