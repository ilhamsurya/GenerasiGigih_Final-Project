require_relative '../../db/db_connector'
class User
    attr_accessor :username, :email
    def initialize(username, email)
        @username = username
        @email = email
    end

    def valid?
        return false if @username.nil? || @email.nil?
        true
    end

    def save
        client = create_db_client
        insert_query = "INSERT INTO users (username, email) VALUES ('#{@username}', '#{@email}')"
        client.query(insert_query)
    end

    def self.get_all
        client = create_db_client
        user = Hash.new
        users = Array.new
        query = client.query('SELECT * FROM users')
        query.each do |data|
            user = {:id => data['id'], :name => data['username'], :email => data['email'], 
                :created_at => data['created_at']}
            users << user
        end
        users
    end

    def self.get_by_id(id)
        client = create_db_client
        user = Hash.new
        users = Array.new
        query = client.query("SELECT * FROM users WHERE id = #{id}")
        query.each do |data|
            user = {:id => data['id'], :name => data['username'], :email => data['email'], 
                :created_at => data['created_at']}
            users << user
        end
        users
    end

    def self.get_username(id)
        client = create_db_client
        user = Hash.new
        users = Array.new
        query = client.query("SELECT username,email FROM users WHERE id = #{id}")
        query.each do |data|
            user = {:name => data['username'],:email => data['email']}
            users << user
        end
        users
    end
end