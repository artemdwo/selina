# include Selenium WebDriver gem (library)
require 'selenium-webdriver'

# basic Page class
class Page
  # variable to share driver object with successors
  @driver = nil

  # initialize method creates driver object
  # for specified browser
  # supports: :firefox, :chrome, :safari
  # default: :chrome
  def initialize(browser = :chrome)
    @driver = Selenium::WebDriver.for browser
  end

  # close browser
  def exit
    @driver.quit
  end
end