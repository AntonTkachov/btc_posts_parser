require 'nokogiri'
require 'open-uri'

class InvestRatingParser
  MAP = {
  /<h1.*?>/ => "===== ",
  "</h1>" => " =====\n\n",
  /<p><small.*<\/small><\/p>/ => "",
  "<h2>" => "= ",
  "</h2>" => " =\n\n",
  "<h3>" => "= ",
  "</h3>" => " =\n\n",
  /<a.*?>/ => "",
  "</a>" => "",
  "<br>" => "\n",
  "<hr>" => "",
  /<img.*?>/ => "",
  "</p><blockquote><p>" => " ",
  "</p></blockquote>" => "\n\n",
  "<ol><li>" => "- ",
  "<ul><li>" => "- ",
  "</li><li>" => "\n- ",
  "</li></ol>" => "\n\n",
  "</li></ul>" => "\n\n",
  /<p.*?>/ => "",
  "</p>" => "\n\n"
  }
  def self.parse_news(link)
    doc = Nokogiri::HTML(open(link))
    element = doc.search('div.col-md-9').search('h3.page-header').first || doc.search('div.col-md-9').search('hr').last
    text = doc.search('div.col-md-9').inner_html.sub(element.to_s, "")
    begin
      element = element.next_sibling
      text = text.sub(element.to_s, "")
    end while !element.next_sibling.nil?
    text = text.gsub(/^\s*/, "").gsub(/\s*$/, "").gsub("\n", "")
    MAP.each do |k,v|
      text = text.gsub(k,v)
    end
    text << "Источник: #{link}"
  end
end