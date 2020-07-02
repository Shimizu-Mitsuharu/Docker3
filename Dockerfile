FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /testapp3
WORKDIR /testapp3
COPY Gemfile /testapp3/Gemfile
COPY Gemfile.lock /testapp3/Gemfile.lock
RUN bundle install
COPY . /testapp3

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]