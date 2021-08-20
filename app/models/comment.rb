class Comment
    attr_accessor :user_id, :post_id, :body, :attachment
    def initialize(user_id, post_id, body, attachment=nil)
        @user_id = user_id
        @body = body
        @attachment = attachment
        @post_id = post_id
    end

    def valid?
        return false if @user_id.nil? || @post_id.nil? || @body.nil?
    end
    def save
        client = create_db_client
        query = "INSERT INTO comments (user_id, post_id, body, attachment) VALUES ('#{@user_id}','#{@post_id}', '#{@body}', \"#{@attachment}\")"
        client.query(query)
        id = client.last_id
        data = client.query("SELECT * FROM comments WHERE id = #{id}").each[0]
        data
    end
end