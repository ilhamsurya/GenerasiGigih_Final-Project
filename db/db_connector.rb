require 'mysql2'

require_relative '../config/environment'

def create_db_client

  Mysql2::Client.new(

    host: ENV['DB_HOST'],

    username: ENV['DB_NAME'],

    password: ENV['DB_USERNAME'],

    database: ENV['DB_PASSWORD']

  )

end