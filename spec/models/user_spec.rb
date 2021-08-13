require_relative '../test_helper'
require_relative '../../app/models/user'

describe User do
  before(:each) do
      @user_mock = double
      params = {
          "id" => 1,
          "username" => "Test",
          "email" => "test@gmail.com",
          "description" => "Young, dumb and broke"
      }
      @user = User.new(params["id"], params["username"], params["email"], params["description"])
      allow(Mysql2::Client).to receive(:new).and_return(@user_mock)
  end

  describe '#getAll' do
    context 'when displaying all registered users' do
        it 'should return all registered users' do

        end
    end
  end

  describe '#getOne' do
    context 'when displaying single registered users' do
        it 'should return single registered users' do

        end
    end
  end

  describe "#Save" do
      context "with valid params" do
        it "should save user data"
      end
      context "with invalid params" do
        it "should return warning"
      end
  end
end