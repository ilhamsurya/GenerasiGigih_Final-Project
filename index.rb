require 'sinatra'
require 'json'
require './app/controllers/user_controller'

## GET USER

get '/users/all' do
  
  UserController.show_all
end

get '/users/:id' do
  UserController.show_one(params)
end

