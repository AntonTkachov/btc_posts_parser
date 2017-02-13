require 'nokogiri'
require 'open-uri'

class NewscryptocoinParser
  MAP = {
  /<div.*>/ => "",
  "</div>" => "",
  /<a.*?>/ => "",
  "Источник</a>" => "",
  "</a>" => "",
  "<strong>" => "",
  "</strong>" => "",
  /<img.*?>/ => "",
  "<p></p>" => "",
  /<p.*?>/ => "",
  "</p>" => "\n\n",
  "&amp;" => "&"
  }
  def self.parse_news(link)
    doc = Nokogiri::HTML(open(link))
    text = doc.search('div.post').inner_html
    text = text.gsub(/^\s*/, "").gsub(/\s*$/, "").gsub("\n", "")
    MAP.each do |k,v|
      text = text.gsub(k,v)
    end
    "===== " + doc.search('h1').inner_html + " =====\n\n" + text + "Источник: #{link}"
  end
end