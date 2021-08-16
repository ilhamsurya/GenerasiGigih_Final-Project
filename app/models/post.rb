require_relative '../../db/db_connector'

class Post
    attr_reader :user_id, :body, :attachment, 

    def initialize(user_id, body, attachment=nil)
        @user_id = user_id,
        @body = body,
        @attachment = attachment
    end

    def valid?
        return false if @post.nil? || @user_id.nil? || @body.size > 1000
        true
    end

    def self.all_post(tag)
        client = create_db_client
        all_post = client.query("SELECT posts.user_id, posts.body, posts.attachment, users.username, hashtags.tag, post_hashtags.created_time 
            FROM posts JOIN post_hashtags ON posts.id = post_hashtags.post_id 
            JOIN hashtags ON hashtags.id = post_hashtags.hashtag_id 
            JOIN users on posts.user_id = users.id WHERE hashtags.tag=\"#{db_client.escape(tag)}\" 
            ORDER BY posts.created_time desc;").each
        all_post
    end

    def save
        return false unless valid?
        client = create_db_client
        save_post = client.query("INSERT INTO posts (user_id, body, attachment) values ('#{@user_id}', '#{@body}', \"#{@attachment}\")")
        save_post
    end


end
