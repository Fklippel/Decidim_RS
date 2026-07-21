FROM decidim/decidim:0.30.9

WORKDIR /code

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
ENTRYPOINT ["bin/docker-entrypoint"]
