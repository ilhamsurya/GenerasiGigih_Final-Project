require 'mysql2'

require_relative '../config/environment'

def create_db_client

  Mysql2::Client.new(

    host: ENV['DB_HOST'],

    username: ENV['DB_USERNAME'],

    password: ENV['DB_PASSWORD'],

    database: ENV['DB_NAME']

  )

end