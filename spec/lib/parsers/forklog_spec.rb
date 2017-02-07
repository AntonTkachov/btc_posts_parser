require 'rails_helper'

RSpec.describe ForklogParser do
  describe "parser ForklogParser" do
    it "takes the link and returns parsed string" do
      parsed_news = ForklogParser.parse_news(file_fixture("forklog_url.txt").read)
      expect(parsed_news).to eq(file_fixture("forklog_news.txt").read)
    end
  end
end