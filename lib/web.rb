require 'webdrivers'
require 'capybara'
require 'capybara/dsl'
require 'uri'

class Web

  include Capybara::DSL

  def initialize
    Capybara.disable_animation = true # for srolling to work faster

    profile = ::Selenium::WebDriver::Firefox::Profile.new
    Capybara.register_driver "selenium-firefox".to_sym do |app|
      options = ::Selenium::WebDriver::Firefox::Options.new
      options.args << '--headless'
      options.profile = profile

      Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
    end

  end

  def blank?(string)
    string.nil? || string.to_s.gsub(/\s/, '').empty?
  end

  def url(url, force = false,format: :wide)
    size = format == :wide ? [1600, 900] : [1600, 1200]
    filename = url.tr(':/?#', '_')
    if force || !File.exist?("#{filename}.png")
      #puts 'loading...'
      uri = URI(url)
      Capybara.current_driver = "selenium-firefox".to_sym
      Capybara.app_host = [uri.scheme, '://', uri.host, blank?(uri.port) ? "" : ":", uri.port].join
      page.driver.browser.manage.window.resize_to(*size)

      visit [uri.path, blank?(uri.query) ? "" : "?#{uri.query}", blank?(uri.fragment) ? "" : "##{uri.fragment}"].join
      sleep 2
      page.save_screenshot("#{filename}.png")
      Capybara.current_session.driver.quit
    end
    filename
  end


end