require_relative '../models/user'

class UserController < Sinatra::Application
  def self.show_all
    user = User.get_all
  end

  def self.show_one(params)
    id = params['id']
    user = User.get_by_id(id)
  
  end

  def self.save(params) 
    username = params['username']
    email = params ['email']
    description = params['description']
    user = User.new(username,email,description)
    if user.save
      return {
        "status" => 201,
        "body" => {
          "message" => "successfuly create new user",
          "data" => user
        }
      }
    else
      return {
        "status" => 400,
        "body" => {
          "message" => "failed to create new user"
          
        }
      }
    end
  end
  
end
