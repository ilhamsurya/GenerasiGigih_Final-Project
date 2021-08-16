require 'sinatra'
require 'json'
require './app/controllers/user_controller'
require './app/controllers/post_controller'
## GET USER

get '/users/all' do
  
  UserController.show_all
end

get '/users/:id' do
  UserController.show_one(params)
end
## GET POST
get '/posts/all' do
  PostController.show_all
end