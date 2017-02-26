require 'nokogiri'
require 'open-uri'

class CoinspotParser
  MAP = {
  /<img.*?>/ => "",
  "<p></p>" => "",
  "</cite></p>" => "\n\n",
  /<div.*?>/ => "",
  "</div>" => "",
  /<h2.*?>/ => "= ",
  "</h2>" => " =\n\n",
  "<h3>" => "= ",
  "</h3>" => " =\n\n",
  /<p><a.*?>/ => "",
  "</a></p>" => "",
  /<a.*?>/ => "",
  "</a>" => "",
  "<br>" => "\n",
  "<em>" => "",
  "</em>" => "",
  "<strong>" => "",
  "</strong>" => "",
  "<ol><li>" => "- ",
  "<ul><li>" => "- ",
  "</li><li>" => "\n- ",
  "</li></ol>" => "\n\n",
  "</li></ul>" => "\n\n",
  /<span.*?>/ => "",
  "</span>" => "",
  "<\/p><p><cite>" => " ",
  "</p><blockquote><p>" => " ",
  "</p></blockquote>" => "\n\n",
  /<p.*?>/ => "",
  "</p>" => "\n\n",
  "<h6>" => "",
  "</h6>" => "\n\n",
  "&amp;" => "&",
  "&lt;" => "<",
  "&gt;" => ">",
  /<\/p><p.*?><cite>/ => " "
  }
  def self.parse_news(link)
    doc = Nokogiri::HTML(open(link))
    text = doc.search('div.blog-content').inner_html
    image = doc.search('div.blog-content').search('div.featured_image').to_s
    eof = doc.search('div.blog-content').search('p.eof').to_s
    divs = doc.search('div.blog-content').search('div.wp-caption')
    divs += doc.search('div.blog-content').search('div.blog-info-wrapper')
    divs += doc.search('div.blog-content').search('em')
    divs += doc.search('div.blog-content').search('h6')
    divs.each do |elem|
      text = text.sub(elem.to_s, "")
    end
    text = text.sub(image, "").sub(eof, "").gsub(/^\s*/, "").gsub(/\s*$/, "").gsub("\n", "")
    MAP.each do |k,v|
      text = text.gsub(k,v)
    end
    if text.split.last == "Источник"
      text = "===== " + doc.search('h1').inner_html + " =====\n\n" + text + ": #{link}"
    else
      text = "===== " + doc.search('h1').inner_html + " =====\n\n" + text + "Источник: #{link}"
    end
    text
  end
end