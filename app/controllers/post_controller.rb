require_relative '../models/post'
require_relative '../../db/db_connector'

class PostController < Sinatra::Application

  def self.show_all
    post = Post.all_post
    return [
        200,
        {
            message: "successfuly load all post",
            posts: post
        }.to_json
    ]
  end
  
  def sort_by_tags
  end
end
