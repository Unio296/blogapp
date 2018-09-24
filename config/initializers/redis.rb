require 'redis'
#uri = URI.parse(Rails.application.credentials.REDIS)
uri = URI.parse(ENV['REDIS'])  #heroku用

REDIS = Redis.new(host: uri.host, port: uri.port)