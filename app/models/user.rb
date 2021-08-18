require_relative '../../db/db_connector'
class User
    attr_accessor :username, :email, :description
    def initialize(username, email, description)
        @username = username
        @email = email
        @description = description
    end

    def valid?
        return false if @username.nil? || @email.nil?
        true
    end

    def save
        client = create_db_client
        insert_query = "INSERT INTO users (username, email, description) VALUES ('#{@username}', '#{@email}', '#{@description}')"
        client.query(insert_query)
    end

    def self.get_all
        client = create_db_client
        @user = Hash.new
        @users = Array.new
        @query = client.query('SELECT * FROM users')
        @query.each do |data|
            @user = {:id => data['id'], :name => data['username'], :email => data['email'], 
                :desc => data['description'], :created_at => data['created_at']}
            @users << @user
        end
        return @users.to_json
    end

    def self.get_by_id(id)
        client = create_db_client
        @user = Hash.new
        @users = Array.new
        @query = client.query("SELECT * FROM users WHERE id = #{id}")
        @query.each do |data|
            @user = {:id => data['id'], :name => data['username'], :email => data['email'], 
                :desc => data['description'], :created_at => data['created_at']}
            @users << @user
        end
        return @users.to_json
    end

    def self.get_username(id)
        client = create_db_client
        @user = Hash.new
        @users = Array.new
        @query = client.query("SELECT username,email FROM users WHERE id = #{id}")
        @query.each do |data|
            @user = {:name => data['username'],:email => data['email']}
            @users << @user
        end
        return @users
    end
end