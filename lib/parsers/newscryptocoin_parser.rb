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
  "<ol><li>" => "- ",
  "<ul><li>" => "- ",
  "</li><li>" => "\n- ",
  "</li></ol>" => "\n\n",
  "</li></ul>" => "\n\n",
  /<p.*?>/ => "",
  "</p>" => "\n\n",
  "&amp;" => "&",
  "&lt;" => "<",
  "&gt;" => ">"
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