require 'rails_helper'

RSpec.describe CryptorussiaParser do
  describe "parser" do
    it "takes the link and returns parsed string" do
      parsed_news = CryptorussiaParser.parse_news(file_fixture("cryptorussia_url.txt").read)
      expect(parsed_news).to eq(file_fixture("cryptorussia_news.txt").read)
    end
  end
end