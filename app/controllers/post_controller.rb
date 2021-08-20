require_relative '../models/post'
require_relative '../models/hashtag'
require_relative '../models/comment'
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

  def self.show_trending
    tags = Hashtag.trending_tags
    return {
      message: "successfuly load 5 trending hashtags in 24 hour",
      trending: tags
    }.to_json
  end
  
  def self.create_post(params,data)
      client = create_db_client
      user_id = params.to_i
      body = data['body']
      attachment = data["attachment"]
      hashtags = data['hashtags']
      username = User.get_username(user_id)
      data_post = adding_post_attachment(user_id,body,attachment)
      
      if hashtags.nil?
        return  {
          message: "succesfully creating new post",
          user_id: user_id,
          post_id: data_post['id'],
          user_info: username,
          body: body,
        }.to_json
      else
        data_tags = adding_tags(hashtags)
        data_tags.each do |tag|
          insert_post_tags = "INSERT INTO post_hashtags(post_id,hashtag_id) VALUES (#{data_post['id']}, #{tag['id']})"
          rawData = client.query(insert_post_tags)
        end
      end

      return  {
        message: "succesfully creating new post",
        user_id: user_id,
        post_id: data_post['id'],
        user_info: username,
        body: body,
        attachment: data_post['attachment'],
        tags: data_tags
      }.to_json

  end

  def self.create_comment(params,data)
      client = create_db_client
      user_id = params['id'].to_i
      post_id = params['post_id'].to_i
      body = data['body']
      attachment = data["attachment"]
      hashtags = data['hashtags']
      username = User.get_username(user_id)
      data_comment = adding_comment_attachment(user_id,post_id,body,attachment)

      if hashtags.nil?
        return  {
          message: "succesfully creating new comment to the post #{data_comment['id']}",
          user_id: user_id,
          post_id: post_id,
          comment_id: data_comment['id'],
          user_info: username,
          body: body,
        }.to_json
      else
        data_tags = adding_tags(hashtags)
        data_tags.each do |tag|
          insert_post_tags = "INSERT INTO comment_hashtags(comment_id,hashtag_id) VALUES (#{data_comment['id']}, #{tag['id']})"
          rawData = client.query(insert_post_tags)
        end
      end

      return {
        message: "succesfully creating new comment to the post #{data_comment['id']}",
        user_id: user_id,
        post_id: post_id,
        comment_id: data_comment['id'],
        username: username,
        body: body,
        attachment: data_comment['attachment'],
        tags: data_tags
      }.to_json
  end

  def self.validating_attachment(file_name,tempfile)
    accepted_formats = ['.jpg', '.JPG','.png','.PNG','.gif','.mp4','.mkv']
    is_accepted_format = accepted_formats.include? File.extname(file_name)

    if is_accepted_format
      File.open("./public/#{file_name}", 'wb') do |f|
        f.write(tempfile.read)
      end
      file_path = "http://localhost:4567/#{file_name}"
      file_path
    else
      return [400, { message: 'file you want to send is not accepted format' }]
    end
  end

  def self.adding_tags(tags)
    post_tags = Hashtag.new(tags)
    data_tags = post_tags.save
    data_tags
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

  def self.adding_comment_attachment(user_id,post_id,body,attachment)
    if attachment.nil?
      comment = Comment.new(user_id, post_id, body)
    else
      comment = Comment.new(user_id, post_id, body, attachment)
    end
    data_comment = comment.save
    data_comment
  end


  
end
