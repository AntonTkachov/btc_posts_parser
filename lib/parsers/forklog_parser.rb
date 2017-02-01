require 'capybara'
require 'capybara/poltergeist'
require 'capybara/dsl'
require 'uri'
include Capybara::DSL

class ForklogParser
  Capybara.default_driver = :poltergeist

  def self.html(link)
    visit URI.encode(link)
    find('#article_content').html
  end
end




