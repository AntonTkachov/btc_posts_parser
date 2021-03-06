require 'nokogiri'
require 'open-uri'

class ForklogParser
  MAP1 = {
  /<!-- article.*?>/ => "",
  /<section.*?>/ => "",
  "</section>" => "",
  /<a.*?>/ => "",
  "</a>" => "",
  /<i.*?>/ => "",
  "</i>" => ""
  }
  MAP = {
  "<p></p>" => "",
  "<h1>" => "===== ",
  "</h1>" => " =====\n\n",
  "<h3>" => "= ",
  "</h3>" => " =\n\n",
  /<span.*?>/ => "",
  "</span>" => "",
  "</p><blockquote><p>" => " ",
  "</p></blockquote><p>" => "\n\n",
  /<\/p><blockquote.*>/ => "",
  /<p>—.*/ => "",
  "<p>" => "",
  "</p>" => "\n\n",
  /<p.*>/ => "",
  "<strong>" => "",
  "</strong>" => "",
  "<ol><li>" => "\n- ",
  "<ul><li>" => "\n- ",
  "</li><li>" => "\n- ",
  "</li></ol>" => "\n\n",
  "</li></ul>" => "\n\n",
  "<em>" => "",
  "</em>" => "\n\n",
  /<img.*?>/ => "",
  "<br>" => "\n",
  "<blockquote>" => "",
  "</blockquote>" => "",
  /<script.*?>/ => "",
  "</script>" => "",
  "<b>" => "",
  "</b>" => "",
  "&amp;" => "&",
  "&lt;" => "<",
  "&gt;" => ">"
  }

  def self.parse_news(link)
    doc = Nokogiri::HTML(open(link))
    text = doc.search('section#article_content').inner_html
    for_removal = doc.search('section#article_content').search('div')
    for_removal += doc.search('section#article_content').search('iframe')
    for_removal.each do |elem|
      text = text.sub(elem.to_s, "")
    end
    MAP1.each do |k,v|
      text = text.gsub(k,v)
    end
    text = text.gsub(/^\s*/, "").gsub(/\s*$/, "").gsub("\n", "")
    MAP.each do |k,v|
      text = text.gsub(k,v)
    end
    text.sub(/Подписывайтесь на новости Forklog в .*?!\n/, "") << "Источник: #{link}"
  end
end
