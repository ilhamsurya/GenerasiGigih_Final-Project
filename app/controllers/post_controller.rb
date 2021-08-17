require_relative '../models/post'
require_relative '../models/hashtag'
require_relative '../../db/db_connector'

class PostController < Sinatra::Application

  def self.show_post(params)
    tag = params["tag"]
    post = Post.post_by_tags(tag)
    return {
      message: "successfuly load post with tag #{tag}",
      posts: post
    }.to_json
    
  end
  
  def self.create_post(params,data)
      client = create_db_client
      user_id = params['id']
      body = data['body']
      attachment = data["attachment"]
      hashtags = data['hashtags']
      username = User.get_by_id(user_id)
      data_attachment = adding_post_attachment(user_id,body,attachment)
      data_tags = adding_tags(hashtags)

      data_tags.each do |tag|
        insert_post_tags = "INSERT INTO post_hashtags(post_id,hashtag_id) VALUES (#{data_attachment['id']}, #{tag['id']})"
        rawData = client.query(insert_post_tags)
      end

      return{
        message: "succesfully creating new post",
        user_id: user_id,
        post_id: data_attachment['id'],
        username: username,
        body: body,
        attachment: data_attachment['attachment'],
        tags: data_tags
      }.to_json

  end

  def self.adding_post_attachment(user_id,body,attachment)
    if attachment.nil?
      post = Post.new(user_id, body)
    else
      post = Post.new(user_id, body, attachment)
    end
    data_post = post.save
    data_post
  end

  def self.adding_tags(tags)
    post_tags = Hashtag.new(tags)
    data_tags = post_tags.save
  end
end
