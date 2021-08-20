require 'sinatra'
require 'json'
require './app/controllers/user_controller'
require './app/controllers/post_controller'



get '/users/all' do
  begin
      content_type :json
      response = UserController.show_all
      response
  rescue => exception
      return [500, {error: exception}.to_json]
  end
  
end

get '/users/:id' do
  begin
      content_type :json
      response = UserController.show_one(params)
      response
  rescue => exception
      return [500, {error: exception}.to_json]
  end
end

post '/users/new' do
  begin
      content_type :json
      params = JSON.parse request.body.read
      response = UserController.save(params)
      response
  rescue => exception
      return [500, {error: exception}.to_json]
  end
end

get '/posts/:tag' do
  begin
      content_type :json
      response = PostController.show_post(params)
      response
  rescue => exception
      return [500, {error: exception}.to_json]
  end
  
end

get '/trending' do
  begin
      content_type :json
      response = PostController.show_trending
      response
  rescue => exception
      return [500, {error: exception}.to_json]
  end
  
end

post '/posts/new/:id' do
  content_type :json
  attachment = params[:attachment]
  begin
    if attachment.nil?
      data = JSON.parse request.body.read
      response = PostController.create_post(params['id'], data)
      response
    else
      file_name = File.basename(attachment[:tempfile])
      tempfile = attachment[:tempfile]
      file_path = PostController.validating_attachment(file_name,tempfile)
      data = { 'body' => params[:body], 'hashtags' => params[:hashtags], 'attachment' => file_path }
      response = PostController.create_post(params['id'], data)
      response
    end
  rescue => exception
    return [500, {error: exception}.to_json]
  end 
end

post '/comment/:post_id/:id' do
  content_type :json
  attachment = params[:attachment]
  begin
    if attachment.nil?
      data = JSON.parse request.body.read
      response = PostController.create_comment(params,data)
      response
    else
      file_name = File.basename(attachment[:tempfile])
      tempfile = attachment[:tempfile]
      file_path = PostController.validating_attachment(file_name,tempfile)
      data = { 'body' => params[:body], 'hashtags' => params[:hashtags], 'attachment' => file_path }
      response = PostController.create_comment(params['id'], data)
      response
    end
  rescue => exception
      return [500, {error: exception}.to_json]
  end
end