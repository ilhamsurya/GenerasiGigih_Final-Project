require_relative '../test_helper'
require_relative '../../app/models/hashtag'
require_relative '../../db/db_connector'

describe User do
  describe "#validation" do
    context "when initialize valid parameter" do
      it "should return true" do
          hashtag = Hashtag.new(["Ikan","Ular"])
          expect(hashtag.valid_tag?).to eq(true)
        end
      end
    context "when initialize invalid parameter" do
      it "should return false" do
          hashtag = hashtag.new(nil)
          expect(hashtag.valid_tag?).to eq(false)
      end
    end
  end

  describe "#initialize" do
    context "given valid attribute" do
        it "should create object that equal with user_params" do
           
        end
    end
  end

 
end