require_relative '../test_helper'
require_relative '../../app/controllers/user_controller'
require_relative '../../app/models/user'

describe UserController do

    describe "#show" do
        context "see all registered user" do
            it "should call method show_all" do            
                users = User.get_all
                actual_user = UserController.show_all
                expect(users).to eq(actual_user)
            end
        end
    end

    describe "#show_by_id" do
        context "see single registered user by id" do
            it "should call method show_one" do            
                user_params = {
                    "id" => 1
                }
                users = User.get_one(user_params["id"])
                actual_user = UserController.show_one(user_params["id"])
                expect(users).to eq(actual_user)
            end
        end
    end
    describe ".save" do
        context "given user_attribute" do
            it "should save user along with the attribute defined" do
                user_params = {
                    "username" => 1
                    ""
                }
            end
        end
    end
end