require_relative '../test_helper'
require_relative '../../app/models/user'

describe User do
  let(:user_mock) {double}

  describe ".initialize" do
    context "given valid attribute" do
        it "should create object that equal with user_valid_attribute" do
            user_params = {
                "username" => "test",
                "email" => "test@gmail.com"
            }
            user = User.new(user_params["username"], user_params["email"])
            expect(user.username).to  eq(user_params["username"])
            expect(user.email).to  eq(user_params["email"])
        end
    end
  end

  describe '#get_all' do
    context 'when displaying all registered users' do
        it 'should return all registered users' do
            get_all = "SELECT * FROM users"
            raw_data = User.get_all
            expect(user_mock).to receive(:query).with(get_by_id).and_return(raw_data)
            expect(get_by_id).to eq(raw_data)
        end
    end
  end

  describe '#get_one' do
    context 'when displaying single registered users' do
        it 'should return single registered users' do
            user_params = {
                "id" => 1
            }
            get_by_id = "SELECT * FROM users WHERE id = #{user_params["id"]}"
            raw_data = [user_params]                

            expect(user_mock).to receive(:query).with(get_by_id).and_return(raw_data)
            expect(get_by_id).to include(id) 

            user = User.get_by_id(id)

            expect(user.id).to eq(id) 
        end
    end
  end

  describe "#save" do
      context "with valid params" do
        it "should save user data"
          

      end
      context "with invalid params" do
        it "should return warning"
      end
  end
end