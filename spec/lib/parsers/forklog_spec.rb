require 'rails_helper'

RSpec.describe ForklogParser do
  describe "parser" do
    it "takes the link and returns parsed string (1 ex)" do
      parsed_news = ForklogParser.parse_news(file_fixture("forklog_url.txt").read)
      expect(parsed_news).to eq(file_fixture("forklog_news.txt").read)
    end
    it "takes the link and returns parsed string (2 ex)" do
      parsed_news = ForklogParser.parse_news(file_fixture("forklog_url_2.txt").read)
      expect(parsed_news).to eq(file_fixture("forklog_news_2.txt").read)
    end
  end
end