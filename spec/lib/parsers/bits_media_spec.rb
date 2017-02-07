require 'rails_helper'

RSpec.describe BitsMediaParser do
  describe "parser BitsMediaParser" do
    it "takes the link and returns parsed string" do
      parsed_news = BitsMediaParser.parse_news(file_fixture("bits_media_url.txt").read)
      expect(parsed_news).to eq(file_fixture("bits_media_news.txt").read)
    end
  end
end