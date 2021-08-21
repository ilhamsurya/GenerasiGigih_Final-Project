require_relative '../test_helper'
require_relative '../../app/controllers/user_controller'
require_relative '../../app/models/user'

describe UserController do

    describe "#show" do
        context "see all registered user" do
            it "should call method show_all" do            
                users = User.get_all
                query_user = UserController.show_all
                actual_user = {
                    message: "returning all user",
                    users: users
                }.to_json
                expect(actual_user).to eq(query_user)
            end
        end
    end

    describe "#show_by_id" do
        context "see single registered user by id" do
            it "should call method show_one" do
                params = {
                    "id" => 1
                }            
                users = User.get_by_id(params["id"])
                query_user = UserController.show_one(params)
                actual_user = {
                    message: "returning single user",
                    users: users
                }.to_json
                expect(actual_user).to eq(query_user)
            end
        end
    end
    describe "#show_by_username" do
        context "see single username registered user by id" do
            it "should call method get_username" do            
                params = {
                    "id" => 1
                }
                users = User.get_username(params["id"])
                query_user = UserController.show_username(params)
                actual_user = {
                    message: "returning username user",
                    users: users
                }.to_json
                expect(actual_user).to eq(query_user)
            end
        end
    end
    describe "#save" do
        context "given valid user_params" do
            it "should save user along with the attribute defined" do
                user_mock = double
                user_params = {
                    "username" => "Hal Jordan",
                    "email" => "haljordan@ymail.co.id"
                }
                expect(User).to receive(:new).with(user_params["username"], user_params["email"]).and_return(user_mock)
                allow(user_mock).to receive(:save) 

                UserController.save(user_params)
            end
        end
    end
end