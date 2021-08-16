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

    def save
        return false unless valid?
        client = create_db_client
        save_post = client.query("INSERT INTO posts (user_id, body, attachment) values ('#{@user_id}', '#{@body}', \"#{@attachment}\")")
        save_post
    end
end
