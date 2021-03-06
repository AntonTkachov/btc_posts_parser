require 'rails_helper'

RSpec.describe CoinspotParser do
  describe "parser" do
    it "takes the link and returns parsed string (1 ex)" do
      parsed_news = CoinspotParser.parse_news(file_fixture("coinspot_url.txt").read)
      expect(parsed_news).to eq(file_fixture("coinspot_news.txt").read)
    end
    it "takes the link and returns parsed string (2 ex)" do
      parsed_news = CoinspotParser.parse_news(file_fixture("coinspot_url_2.txt").read)
      expect(parsed_news).to eq(file_fixture("coinspot_news_2.txt").read)
    end
    it "takes the link and returns parsed string (3 ex)" do
      parsed_news = CoinspotParser.parse_news(file_fixture("coinspot_url_3.txt").read)
      expect(parsed_news).to eq(file_fixture("coinspot_news_3.txt").read)
    end
  end
end