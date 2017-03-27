# require_relative 'bundle/bundler/setup'
require 'http'
require 'zlib'
require 'json'

config = JSON.parse(File.read(ENV['PAYLOAD_FILE']))
ENV.update config

# get data
res = HTTP.get('https://tcgbusfs.blob.core.windows.net/blobyoubike/YouBikeTP.gz')

if res.code != 200
  puts "Get Data Failed!"
  return
else
  puts "Get Data Successlly!"
end
gz = Zlib::GzipReader.new(StringIO.new(res.body.to_s))
data = JSON.parse(gz.read)

# update
body = {"records":data['retVal'].values}
res = HTTP.basic_auth(:user => ENV['ACCOUNT'], :pass => ENV['PASSWORD'])
          .post("https://nearest-ubike.herokuapp.com/v1/update", :json => body)
if res.code !=202
  puts "Update Data Failed!"
else
  puts "Update Data Successlly!"
end
