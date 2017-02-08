require 'nokogiri'
require 'open-uri'

class BitnovostiParser
  MAP = {
  /<h1.*?>/ => "===== ",
  "</h1>" => " =====\n\n",
  "<h2>" => "= ",
  "</h2>" => " =\n\n",
  "<h3>" => "= ",
  "</h3>" => " =\n\n",
  /<p>\u00A0<\/p>/ => "",
  /<p><img.*?><\/p>/ => "",
  /<p><a.*?><img.*?><\/a><\/p>/ => "",
  /<a.*?>/ => "",
  "</a>" => "",
  /<img.*?>/ => "",
  /<span.*?>/ => "",
  "</span>" => "",
  "</p><ol><li>" => "\n- ",
  "</p><ul><li>" => "\n- ",
  "</li><li>" => "\n- ",
  "</li></ol>" => "\n\n",
  "</li></ul>" => "\n\n",
  /<\/p><blockquote.*?><p>/ => " ",
  "<p>" => "",
  "</p>" => "\n\n",
  /<p.*>/ => "",
  "<strong>" => "",
  "</strong>" => "",
  "<em>" => "",
  "</em>" => "",
  "<blockquote>" => "",
  "</blockquote>" => "",
  /<section.*?>/ => "",
  "</section>" => "",
  "<hr>" => ""
  }
  def self.parse_news(link)
    doc = Nokogiri::HTML(open(link))
    data = doc.search('article').search('p.postmetadata').to_s
    element = doc.search('article').search('div#jp-post-flair').first.previous_element.previous_element.previous_element
    text = doc.search('article').inner_html.sub(element.to_s, "").sub(data, "").sub(doc.search('section.entry').first.first_element_child.to_s, "")
    begin
      element = element.next_element
      text = text.sub(element.to_s, "")
    end while !element.next_element.nil?
    text = text.sub(/<p><span.*?><\/span><\/p>/, "").gsub(/^\s*/, "").gsub(/\s*$/, "").gsub("\n", "")
    MAP.each do |k,v|
      text = text.gsub(k,v)
    end
    text << "Источник: #{link}"
  end
end