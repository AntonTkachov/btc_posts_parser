require 'nokogiri'
require 'open-uri'

class CoinspotParser
  MAP = {
  /<div.*>/ => "",
  "</div>" => "",
  "<h2>" => "= ",
  "</h2>" => " =\n\n",
  /<a.*?>/ => "",
  "</a>" => "",
  "<br>" => "\n",
  /<img.*?>/ => "",
  /<span.*?>/ => "",
  "</span>" => "",
  "</p><p><cite>" => " ",
  "</cite></p>" => "\n\n",
  "<p>" => "",
  "</p>" => "\n\n",
  "<h6>" => "",
  "</h6>" => "\n\n"
  }
  def self.parse_news(link)
    doc = Nokogiri::HTML(open(link))
    text = doc.search('div.blog-content').inner_html
    image = doc.search('div.blog-content').search('div.featured_image').to_s
    eof = doc.search('div.blog-content').search('p.eof').to_s
    text = text.sub(image, "").sub(eof, "").gsub(/^\s*/, "").gsub(/\s*$/, "").gsub("\n", "")
    MAP.each do |k,v|
      text = text.gsub(k,v)
    end
    "===== " + doc.search('h1').inner_html + " =====\n\n" + text + "Источник: #{link}"
  end
end