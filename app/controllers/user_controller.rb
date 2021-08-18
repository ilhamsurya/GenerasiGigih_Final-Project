require_relative '../models/user'
require_relative '../../db/db_connector'

class UserController < Sinatra::Application
  def self.show_all
    user = User.get_all
  end

  def self.show_one(params)
    id = params['id']
    user = User.get_by_id(id)    
  end

  def self.save(params) 
    if params.nil?
      return {
        message: "data not available, please try again",
      }.to_json

    elsif params['username'].nil? || params['email'].nil?
      return {
        message:  "data not available, please make sure that the data already inputed",
      }.to_json
    
    end

    username = params['username']
    email = params ['email']
    description = params['description']
    user = User.new(username,email,description)

    return  {
      message: "succesfully created new user",
      username: username,
      email: email,
      description: description
    }.to_json
  end

  

  
end
