require_relative '../models/user'
require_relative '../../db/db_connector'

class UserController < Sinatra::Application
  def self.show_all
    user = User.get_all
  end

  def self.show_one(params)
    id = params['id']
    user = User.get_by_id(id)
    return [
      200,
      {
          message: 'success loading a user',
          user: user,
      }.to_json
    ]
  end

  def self.save(params) 
    if data.nil?
      return [
        400,
        {
          message: "data not available, please try again",
         
        }.to_json
      ]
    elsif data['username'].nil? or data['username'].empty? or data['email'].nil? or data['email'].empty?
      return [
        400,
        {
          message:  "data not available, please make sure that the data already inputed",
        }.to_json
      ]
    end

    username = params['username']
    email = params ['email']
    description = params['description']
    user = User.new(username,email,description)
  end

  def create_post(id,params)
    client = create_db_client
    user_id = id.to_i
    body = params['body']
    attachment = params['attachment']
 
    if attachment.nil?
      post = Post.new(user_id, body, attachment)
      data = post.save
    else
      post = Post.new(user_id, body, nil)
      data = post.save
    end
    
    username = client.query("SELECT username FROM users WHERE id = #{user_id}").each[0]['username']
  end

  
end
