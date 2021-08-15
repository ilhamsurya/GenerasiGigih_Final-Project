require_relative '../../db/db_connector'
class User
    attr_accessor :id, :username, :email, :description
    def initialize(params)
        @id = params["id"]
        @username = params["username"]
        @email = params["email"]
        @description = params["description"]
    end

    def valid?
        return false if @username.nil? || @email.nil?
        true
    end
    ## Save new user
    def save
        client = create_db_client
        insert_query = "INSERT INTO users (username, email, description) VALUES ('#{@username}', '#{@email}', '#{@description}')"
        client.query(insert_query)
    end
    ## GET All User
    def self.get_all
        client = create_db_client
        @user = Hash.new
        @users = Array.new
        @query = client.query('SELECT * FROM users')
        @query.each do |data|
            @user = {:id => data['id'], :name => data['name'], :email => data['email'], 
                :desc => data['description'], :created_at => data['created_at']}
            @users << @user
        end
        return @users.to_json
    end
    ## GET Single User
    def self.get_by_id(id)
        client = create_db_client
        @user = Hash.new
        @users = Array.new
        @query = client.query("SELECT * FROM users WHERE id = #{id}")
        @query.each do |data|
            @user = {:id => data['id'], :name => data['name'], :email => data['email'], 
                :desc => data['description'], :created_at => data['created_at']}
            @users << @user
        end
        return @users.to_json
    end
end