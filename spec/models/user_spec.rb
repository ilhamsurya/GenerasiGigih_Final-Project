require_relative '../test_helper'
require_relative '../../app/models/user'
require_relative '../../app/controllers/user_controller'
require_relative '../../db/db_connector'

describe User do
  describe "#validation" do
    context "when initialize valid parameter" do
      it "should return true" do
          user = User.new("Gurame","Gurame@gmail.com")
          expect(user.valid?).to eq(true)
        end
      end
    context "when initialize invalid parameter" do
      it "should return false" do
          user = User.new("Gurame",nil)
          expect(user.valid?).to eq(false)
      end
    end
  end

  describe "#initialize" do
    context "given valid attribute" do
        it "should create object that equal with user_params" do
            user_params = {
                "username" => "test",
                "email" => "test@gmail.com"
            }
            username = user_params["username"]
            email = user_params["email"]
            user = User.new(username, email)
            expect(user.username).to eq(username)
            expect(user.email).to eq(email)
        end
    end
  end

  describe '#get_all' do
    context 'when displaying all registered users' do
        it 'should return all registered users' do
            mock_client = double
            select_query = "SELECT * FROM users"
            mock_raw_data = [
                {
                    "username" => "ilham",
                    "email" => "ilhamsurya.m@gmail.com",
                }
            ]
            
            allow(Mysql2::Client).to receive(:new).and_return(mock_client)
            expect(mock_client).to receive(:query).with(select_query).and_return(mock_raw_data)
            User.get_all
        end
    end
  end

  describe '#get_one' do
    context 'when displaying single registered users' do
        it 'should return single registered users' do
            mock_client = double
            id = 1
            select_query_with_id = "SELECT * FROM users WHERE id = #{id}"
            mock_raw_data = [
                {
                    "username" => "ilham",
                    "email" => "ilhamsurya.m@gmail.com",
                }
            ]

            allow(Mysql2::Client).to receive(:new).and_return(mock_client)
            expect(mock_client).to receive(:query).with(select_query_with_id).and_return(mock_raw_data)

            User.get_by_id(id)
        end
    end
  end

  describe "#save" do
      context "with valid params" do
        it "should save user data" do
          mock_client = double
          
          user_params = {
              "username" => "test",
              "email" => "test@ymail"
          }
          insert_query = "INSERT INTO users (username, email) VALUES ('#{user_params["username"]}', '#{user_params["email"]}')"
          allow(Mysql2::Client).to receive(:new).and_return(mock_client)
          expect(mock_client).to receive(:query).with(insert_query)
          user = User.new(user_params["username"], user_params["email"])
          user.save
        end
      end
     
  end
end