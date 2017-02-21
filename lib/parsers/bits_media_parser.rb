require 'nokogiri'
require 'open-uri'

class BitsMediaParser
  MAP1 = {
  /<div.*>/ => "",
  "</div>" => "",
  /<br.*>/ => "",
  "</br>" => "",
  /<!--.*?>/ => "",
  /<ul.*>/ => "",
  "</ul>" => "",
  "<p>Последние новости:</p>" => "",
  "<p><a href=\"/news/\">Все новости</a></p>" => ""
  }
  MAP = {
  "<h3>" => "= ",
  "</h3>" => " =\n\n",
  "<h2>" => "= ",
  "</h2>" => " =\n\n",
  /<span.*?>/ => "",
  "</span>" => "",
  /<\/p><blockquote.*?><p>/ => " ",
  "<p>" => "",
  "</p>" => "\n\n",
  /<p.*>/ => "",
  "<strong>" => "",
  "</strong>" => "",
  /<a.*?>/ => "",
  "</a>" => "",
  /<img.*?>/ => "",
  /<blockquote.*?>/ => "",
  "</blockquote>" => "",
  /<i.*?>/ => "",
  "</i>" => "",
  /<script.*?>/ => "",
  "</script>" => "",
  "&amp;" => "&",
  "&lt;" => "<",
  "&gt;" => ">"
  }

  def self.parse_news(link)
    doc = Nokogiri::HTML(open(link))
    text = doc.search('div.text_content').inner_html
    footer = doc.search('div.text_content').search('div.article_footer').inner_html
    author = doc.search('div.text_content').search('div.authorlink').inner_html
    ul = doc.search('div.text_content').search('ul.news').inner_html
    text = text.sub(footer, "").sub(author, "").sub(ul, "")
    MAP1.each do |k,v|
      text = text.gsub(k,v)
    end
    text = text.gsub(/^\s*/, "").gsub(/\s*$/, "").gsub("\n", "")
    MAP.each do |k,v|
      text = text.gsub(k,v)
    end
    "===== " + doc.search('h1').inner_html + " =====" + text + "Источник: #{link}"
  end
end