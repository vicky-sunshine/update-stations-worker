FROM ruby:2.3.1

WORKDIR /worker

ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install

ADD update_ubike_stations.rb .

ENTRYPOINT ruby update_ubike_stations.rb
