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

 
end