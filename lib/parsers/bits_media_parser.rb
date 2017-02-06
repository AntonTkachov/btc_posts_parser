require 'nokogiri'
require 'open-uri'

class BitsMediaParser
  MAP = {
  "<h3>" => "= ",
  "</h3>" => " =\n\n",
  /<span.*?>/ => "",
  "</span>" => "",
  "<p>Последние новости:</p>" => "",
  "<a href=\"/news/\">Все новости</a>" => "",
  /<\/p>\s+<blockquote.*?>\s+<p>/ => " ",
  "<p>" => "",
  "</p>" => "",
  /<p.*>/ => "",
  "<strong>" => "",
  "</strong>" => "",
  /<a.*?>/ => "",
  "</a>" => "",
  /<img.*?>/ => "",
  /<!--.*?>/ => "",
  "<blockquote>" => "",
  "</blockquote>" => "",
  /<div.*>/ => "",
  "</div>" => "",
  /<i.*?>/ => "",
  "</i>" => "",
  /<script.*?>/ => "",
  "</script>" => "",
  /<br.*>/ => "",
  "</br>" => "",
  /<ul.*>/ => "",
  "</ul>" => ""
  }

  def self.parse_news(link)
    doc = Nokogiri::HTML(open(link))
    text = "===== " + doc.search('h1').inner_html + " =====\n\n\n\n"
    text << doc.search('div.text_content').inner_html
    footer = doc.search('div.text_content').search('div.article_footer').inner_html
    author = doc.search('div.text_content').search('div.authorlink').inner_html
    ul = doc.search('div.text_content').search('ul.news').inner_html
    text = text.sub(footer, "").sub(author, "").sub(ul, "")
    MAP.each do |k,v|
      text = text.gsub(k,v)
    end
    text << "Источник: #{link}"
  end
end