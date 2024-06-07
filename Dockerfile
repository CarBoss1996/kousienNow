FROM ruby:3.2.3
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN apt-get update -qq \
    && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    build-essential \
    libpq-dev \
    vim \
    libvips42 \
    libvips-dev \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn

RUN mkdir /myapp
WORKDIR /myapp

COPY package.json yarn.lock ./
RUN yarn install

RUN yarn global add nodemon esbuild

RUN gem install bundler

COPY . /myapp

CMD ["nodemon", "--watch", "./app/assets/stylesheets/", "--ext", "scss", "--exec", "yarn build:css"]