require 'rails_helper'

RSpec.describe NewscryptocoinParser do
  describe "parser" do
    it "takes the link and returns parsed string" do
      parsed_news = NewscryptocoinParser.parse_news(file_fixture("newscryptocoin_url.txt").read)
      expect(parsed_news).to eq(file_fixture("newscryptocoin_news.txt").read)
    end
  end
end