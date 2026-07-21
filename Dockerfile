FROM decidim/decidim:0.30.9
WORKDIR /code
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
RUN SECRET_KEY_BASE=dummy RAILS_ENV=production bundle exec rails assets:precompile
ENTRYPOINT ["bin/docker-entrypoint"]
