require_relative '../models/post'
require_relative '../models/hashtag'
require_relative '../models/comment'
require_relative '../../db/db_connector'

class PostController < Sinatra::Application
  def self.show_post(params)
    tag = params['tag']
    post = Post.post_by_tags(tag)
    {
      message: "successfuly load post with tag #{tag}",
      posts: post
    }.to_json
  end

  def self.show_trending
    tags = Hashtag.trending_tags
    {
      message: 'successfuly load 5 trending hashtags in 24 hour',
      trending: tags
    }.to_json
  end

  def self.create_post(params, data)
    client = create_db_client
    user_id = params.to_i
    body = data['body']
    attachment = data['attachment']
    hashtags = data['hashtags']
    username = User.get_username(user_id)
    data_post = adding_post_attachment(user_id, body, attachment)
    if hashtags.nil?
      return {
        message: 'succesfully creating new post',
        user_id: user_id,
        post_id: data_post['id'],
        user_info: username,
        body: body
      }.to_json
    else
      data_tags = adding_tags(hashtags)
      data_tags.each do |tag|
        insert_post_tags = "INSERT INTO post_hashtags(post_id,hashtag_id) VALUES (#{data_post['id']}, #{tag['id']})"
        client.query(insert_post_tags)
      end
    end

    {
      message: 'succesfully creating new post',
      user_id: user_id,
      post_id: data_post['id'],
      user_info: username,
      body: body,
      attachment: data_post['attachment'],
      tags: data_tags
    }.to_json
  end

  def self.create_comment(params, data)
    client = create_db_client
    user_id = params['id'].to_i
    post_id = params['post_id'].to_i
    body = data['body']
    attachment = data['attachment']
    hashtags = data['hashtags']
    username = User.get_username(user_id)
    data_comment = adding_comment_attachment(user_id, post_id, body, attachment)

    if hashtags.nil?
      return {
        message: "succesfully creating new comment to the post #{data_comment['id']}",
        user_id: user_id,
        post_id: post_id,
        comment_id: data_comment['id'],
        user_info: username,
        body: body
      }.to_json
    else
      data_tags = adding_tags(hashtags)
      data_tags.each do |tag|
        insert_post_tags = "INSERT INTO comment_hashtags(comment_id,hashtag_id) VALUES (#{data_comment['id']}, #{tag['id']})"
        client.query(insert_post_tags)
      end
    end

    {
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

  def self.validating_attachment(file_name, tempfile)
    accepted_formats = ['.jpg', '.JPG', '.png', '.PNG', '.gif', '.mp4', '.mkv']
    is_accepted_format = accepted_formats.include? File.extname(file_name)

    unless is_accepted_format
      [400, { message: 'format not allowed' }]
    else
      File.open("./public/#{file_name}", 'wb') do |f|
        f.write(tempfile.read)
      end
      "http://localhost:4567/#{file_name}"

    end
  end

  def self.adding_tags(tags)
    post_tags = Hashtag.new(tags)
    post_tags.save
  end

  def self.adding_post_attachment(user_id, body, attachment)
    post = if attachment.nil?
             Post.new(user_id, body)
           else
             Post.new(user_id, body, attachment)
           end
    post.save
  end

  def self.adding_comment_attachment(user_id, post_id, body, attachment)
    comment = if attachment.nil?
                Comment.new(user_id, post_id, body)
              else
                Comment.new(user_id, post_id, body, attachment)
              end
    comment.save
  end
end
