FROM --platform=linux/amd64 ruby:2.6.6 AS rails-4-docker

ARG TEST_VAR
ARG TEST_VAR2
ARG BUNDLE_ENTERPRISE_CONTRIBSYS_COM

RUN apt-get update && \
    apt-get install -y nodejs \
    postgresql-client

WORKDIR /app
COPY Gemfile* .

#RUN echo "Bundle: $BUNDLE_ENTERPRISE_CONTRIBSYS_COM"
#RUN echo $BUNDLE_ENTERPRISE_CONTRIBSYS_COM
RUN bundle config enterprise.contribsys.com $BUNDLE_ENTERPRISE_CONTRIBSYS_COM

RUN bundle _1.17.2_ install --path=vendor/cache

COPY . .
COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["bundle", "_1.17.2_", "exec", "rails", "s", "-b", "0.0.0.0"]
