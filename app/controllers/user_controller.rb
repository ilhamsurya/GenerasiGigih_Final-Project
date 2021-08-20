require_relative '../models/user'
require_relative '../../db/db_connector'

class UserController < Sinatra::Application
  def self.show_all
    user = User.get_all
    return {
      message: "returning all user",
      users: user
    }.to_json
  end

  def self.show_one(params)
    id = params['id']
    user = User.get_by_id(id)    
    return {
      message: "returning single user",
      users: user
    }.to_json
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
    user = User.new(username,email)

    return  {
      message: "succesfully created new user",
      username: username,
      email: email,
    }.to_json
  end

  

  
end
