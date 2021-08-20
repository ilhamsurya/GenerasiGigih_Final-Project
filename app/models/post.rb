require_relative '../../db/db_connector'

class Post
    attr_accessor :user_id, :body, :attachment
    def initialize(user_id, body, attachment=nil)
        @user_id = user_id
        @body = body
        @attachment = attachment
    end

    def valid?
        return false if @post.nil? || @user_id.nil? || @body.size > 1000
        true
    end

    def save
        client = create_db_client
        save_post = client.query("INSERT INTO posts (user_id, body, attachment) values ('#{@user_id}', '#{@body}', \"#{@attachment}\")")
        id = client.last_id
        data = client.query("SELECT * FROM posts WHERE id = #{id}").each[0]
        data
    end

    def self.post_by_tags(tag)
        client = create_db_client
        @post = Hash.new
        @posts = Array.new
        @query = client.query("SELECT posts.user_id, posts.body, posts.attachment, users.username, hashtags.tag, post_hashtags.created_at 
            FROM posts JOIN post_hashtags ON posts.id = post_hashtags.post_id 
            JOIN hashtags ON hashtags.id = post_hashtags.hashtag_id 
            JOIN users on posts.user_id = users.id
            WHERE hashtags.tag = \"#{tag}\"
            ORDER BY posts.created_at desc;")
        @query.each do |data|
            @post = {:user_id => data['user_id'], :body => data['body'], :username => data['username'], 
                :hashtags => data['tag'], :created_at => data['created_at']}
            @posts << @post
        end
        @posts
    end

end
