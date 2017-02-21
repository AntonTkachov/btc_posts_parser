require 'rails_helper'

RSpec.describe InvestRatingParser do
  describe "parser" do
    it "takes the link and returns parsed string" do
      parsed_news = InvestRatingParser.parse_news(file_fixture("invest_rating_url.txt").read)
      expect(parsed_news).to eq(file_fixture("invest_rating_news.txt").read)
    end
  end
end