require 'rails_helper'

RSpec.describe BitnovostiParser do
  describe "parser" do
    it "takes the link and returns parsed string" do
      parsed_news = BitnovostiParser.parse_news(file_fixture("bitnovosti_url.txt").read)
      expect(parsed_news).to eq(file_fixture("bitnovosti_news.txt").read)
    end
  end
end