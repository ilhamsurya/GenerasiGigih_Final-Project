require_relative '../test_helper'
require_relative '../../app/models/comment'
require_relative '../../db/db_connector'


describe Comment do

  describe "#initialize" do
    context "given valid attribute" do
        it "should create object that equal with comment_params" do
            comment_params = {
                "user_id" => 1,
                "post_id" => 1,
                "body" => "test",
            }
            user_id = comment_params["user_id"]
            post_id = comment_params["post_id"]
            body = comment_params["body"]
            comment = Comment.new(user_id, post_id, body)
            expect(comment.user_id).to eq(user_id)
            expect(comment.post_id).to eq(post_id)
            expect(comment.body).to eq(body)
        end
    end
  end

  describe "#save" do
      context "with valid params" do
        it "should save user data" do
          client = create_db_client
          comment_mock = double
          comment_params = {
                "user_id" => 1,
                "post_id" => 1,
                "body" => 'test',
                "attachment" => 'test_attachment.pdf'
          }
          insert_query = "INSERT INTO comments (user_id, post_id, body, attachment) VALUES ('#{comment_params["user_id"]}','#{comment_params["post_id"]}', '#{comment_params["body"]}', \"#{comment_params["attachment"]}\")"
          new_comment = Comment.new(comment_params["user_id"],comment_params["post_id"],comment_params["body"], comment_params["attachment"])
          saved_comment = new_comment.save
          expect(saved_comment['user_id']).to eq(1)
          expect(saved_comment['post_id']).to eq(1)
          expect(saved_comment['body']).to eq('test')
          expect(saved_comment['attachment']).to eq('test_attachment.pdf')
        
        end
      end
      context "with invalid params" do
        it "shouldnt save any data" do
          comment_params = {
                "user_id" => nil,
                "post_id" => nil,
                "body" => nil,
          }
          comment = Comment.new(comment_params["user_id"], comment_params["post_id"], comment_params["body"])
          valid_comment = comment.valid?
          expect(valid_comment).to eq(false)
      end
    end
  end
end