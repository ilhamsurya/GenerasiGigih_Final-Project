require_relative '../../db/mysql_connector'
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
        insert_query = "INSERT INTO USERS (username, email, description) VALUES ('#{@username}', '#{@email}', '#{@description}')"
        
        client.query(insert_query)
    end
    ## GET All User
    def self.get_all
        client = create_db_client
        rawData = client.query('SELECT * FROM USERS')
        items = []
        rawData.each do |data|
        item = Item.new(data['username'], data['email'], data['description'])
        items.push(item)
        end
        items
    end
    ## GET Single User
    def self.get_by_id(id)
        client = create_db_client
        users = Array.new
        rawData = client.query("SELECT * FROM USERS WHERE id = #{id}")
        rawData.each do |data|
            user = User.new(data);
            users.push(user)
        end
        users
    end
end