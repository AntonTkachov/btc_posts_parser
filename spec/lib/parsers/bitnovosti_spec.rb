require 'rails_helper'

RSpec.describe BitnovostiParser do
  describe "parser" do
    it "takes the link and returns parsed string (1 ex)" do
      parsed_news = BitnovostiParser.parse_news(file_fixture("bitnovosti_url.txt").read)
      expect(parsed_news).to eq(file_fixture("bitnovosti_news.txt").read)
    end
    it "takes the link and returns parsed string (2 ex)" do
      parsed_news = BitnovostiParser.parse_news(file_fixture("bitnovosti_url_2.txt").read)
      expect(parsed_news).to eq(file_fixture("bitnovosti_news_2.txt").read)
    end
  end
end