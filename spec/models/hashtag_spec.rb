require_relative '../test_helper'
require_relative '../../app/models/hashtag'
require_relative '../../db/db_connector'

describe Hashtag do
  describe "#validation" do
    context "when initialize valid parameter" do
      it "should return true" do
            hashtag_value = ["#Ikan","#Ular"]
            hashtag = Hashtag.new(hashtag_value)
            expect(hashtag.valid_tag?).to eq(true)
        end
      end
  end

  describe "#formatted" do
    context "when getting new hashtag" do
      it "should return formatted hashtag" do
            hashtag_value = ["#Ikan","#Ular"]
            hashtag = Hashtag.new(hashtag_value)
            hashtag.formatted_hashtag
            
            expect(hashtag).to eq(hashtag)
        end
      end
  end

  describe "#save" do
    context "when getting params for new hashtag" do
      it "should save the hashtag" do
          mock_client = double
          
          hashtag_params = {
            "hashtag" => ['test']
          }
          insert_query = "INSERT INTO hashtags(tag,count) VALUES ('#{hashtag_params["hashtag"]}', 1) ON DUPLICATE KEY UPDATE count = VALUES(count) + 1"
          hashtag = Hashtag.new(hashtag_params["hashtag"])
          hashtage_value = hashtag.save
          expect(hashtage_value[0]['tag']).to eq('test')
        end
      end
  end
  describe "#trending" do
    context "when getting params for new hashtag" do
      it "should see top 5 hashtag in 24 hour" do
          
        end
      end
  end
end