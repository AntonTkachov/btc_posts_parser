require 'rails_helper'

RSpec.describe CoinspotParser do
  describe "parser" do
    it "takes the link and returns parsed string" do
      parsed_news = CoinspotParser.parse_news(file_fixture("coinspot_url.txt").read)
      expect(parsed_news).to eq(file_fixture("coinspot_news.txt").read)
    end
  end
end