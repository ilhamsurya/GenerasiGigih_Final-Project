require_relative '../test_helper'
require_relative '../../app/models/post'
require_relative '../../db/db_connector'


describe Post do
  describe "#validation" do
    context "when initialize valid parameter" do
      it "should return true" do
            post_params = {
                "user_id" => 1,
                "body" => "ini post testing"
            }
            user_id = post_params["user_id"]  
            body = post_params["body"]
            post = Post.new(user_id,body)
            expect(post.valid?).to eq(true)
        end
      end
  end

  describe "#save" do
    context "when getting params for new post" do
      it "should save the post" do
          client = create_db_client
          mock_client = double
          post_params = {
              "user_id" => 1,
              "body" => 'ini pesan nya',
              "attachment" => 'test_attachment.pdf'
          }
          insert_query ="INSERT INTO posts (user_id, body, attachment) values ('#{post_params["user_id"]}', '#{post_params["body"]}', \"#{post_params["attachment"]}\")"
          post = Post.new(post_params["user_id"], post_params["body"], post_params["attachment"])
          saved_post = post.save
          expect(saved_post['user_id']).to eq(1)
          expect(saved_post['body']).to eq('ini pesan nya')
          expect(saved_post['attachment']).to eq('test_attachment.pdf')
        end
      end
  end

end