# require 'capybara'
# require 'capybara/poltergeist'
# require 'capybara/dsl'
# require 'uri'
# include Capybara::DSL
#
# class ForklogParser
#   Capybara.default_driver = :poltergeist
#
#   def self.html(link)
#     visit URI.encode(link)
#     find('section#article_content').inner_html
#   end
# end

require 'nokogiri'
require 'open-uri'

class ForklogParser
  MAP = {
  "<h1>" => "===== ",
  "</h1>" => " =====\n\n",
  "<h3>" => "= ",
  "</h3>" => " =\n\n",
  "</p>\n<blockquote><p>" => " ",
  "</p></blockquote>\n<p>" => "\n\n",
  /<\/p>\n<blockquote.*>/ => "",
  /<p>—.*/ => "",
  "<p>" => "",
  "</p>" => "\n\n",
  /<p.*>/ => "",
  "<strong>" => "",
  "</strong>" => "",
  /<a.*?>/ => "",
  "</a>" => "",
  "<em>" => "",
  "</em>" => "\n\n",
  /<section.*?>/ => "",
  "</section>" => "",
  /<img.*?>/ => "",
  /<!-- article.*?>/ => "",
  "<blockquote>" => "",
  "</blockquote>" => "",
  /<span.*?>/ => "",
  "</span>" => "",
  /<div.*>/ => "",
  "</div>" => "",
  /<i.*?>/ => "",
  "</i>" => "",
  /<script.*?>/ => "",
  "</script>" => ""
  }

  def self.parse_news(link)
    doc = Nokogiri::HTML(open(link))
    text = doc.search('section#article_content').inner_html
    MAP.each do |k,v|
      text = text.gsub(k,v)
    end
    text.sub(/Подписывайтесь на новости Forklog в .*?!\n/, "") << "Источник: #{link}"
  end
end
