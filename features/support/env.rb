require 'selenium-webdriver'
require 'cucumber'
require 'capybara/cucumber'
require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'site_prism'

Capybara.configure  do |capybara|

  Capybara.default_max_wait_time = 0.5

  Capybara.register_driver :selenium_ff do |app|

  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 600

  Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => client,
                                 desired_capabilities: {
                                     "ffOptions" => {
                                         "args" => %w{ window-size=1580,1024 }
                                     }
                                 }
  )
  end

capybara.default_driver = :selenium_ff

end







