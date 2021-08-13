ENV["SINATRA_ENV"] ||= "development"
ENV["DB_HOST"] ||= "localhost"
ENV["DB_NAME"] ||= "food_oms_db"
ENV["DB_USERNAME"] ||= "admin"
ENV["DB_PASSWORD"] ||= "password"
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'], ENV["DB_NAME"], ENV["DB_HOST"], ENV["DB_USERNAME"], ENV["DB_PASSWORD"])