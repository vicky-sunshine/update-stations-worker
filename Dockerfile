FROM soumyaray/ruby-http:2.3.1

WORKDIR /worker

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY update_ubike_stations.rb .

ENTRYPOINT ["ruby", "update_ubike_stations.rb"]
