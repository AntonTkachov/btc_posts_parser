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
  "<h1>" => "=====",
  "</h1>" => "=====",
  "<h3>" => "=",
  "</h3>" => "=\n\n",
  "<p>" => "",
  "</p>" => "\n\n"
  }

  def self.html(link)
    doc = Nokogiri::HTML(open(link))
    text = doc.search('section#article_content').inner_html
    MAP.each do |k,v|
      text = text.gsub(k,v)
    end
    text
  end
end
