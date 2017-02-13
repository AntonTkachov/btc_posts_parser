require 'nokogiri'
require 'open-uri'

class CryptorussiaParser
  MAP = {
  /<div.*?>/ => "",
  "</div>" => " ",
  /<!--.*?>/ => "",
  /<a.*?>/ => "",
  "</a>" => "",
  "<ol><li>" => "- ",
  "<ul><li>" => "- ",
  "</li><li>" => "\n- ",
  "</li></ol>" => "\n\n",
  "</li></ul>" => "\n\n",
  "</p><blockquote><p>" => " ",
  "</p></blockquote>" => "\n\n",
  "<br>" => "\n",
  "<em>" => "",
  "</em>" => "",
  "<strong>" => "",
  "</strong>" => "",
  /<img.*?>/ => "",
  /<p.*?>/ => "",
  "</p>" => "\n\n",
  "&amp;" => "&"
  }
  def self.parse_news(link)
    doc = Nokogiri::HTML(open(link))
    text = doc.search('div.field-name-body').inner_html
    text = text.gsub(/^\s*/, "").gsub(/\s*$/, "").gsub("\n", "")
    if text.split("/").last == "div>"
      text = "===== " + doc.search('h1').inner_html + " =====\n\n" + text + "\n\nИсточник: #{link}"
    else
      text = "===== " + doc.search('h1').inner_html + " =====\n\n" + text + "Источник: #{link}"
    end
    MAP.each do |k,v|
      text = text.gsub(k,v)
    end
    text
  end
end