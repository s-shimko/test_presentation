require 'selenium-webdriver'
require 'cucumber'
require 'capybara/cucumber'
require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'site_prism'

# ---------Browser------------------

Capybara.configure  do |capybara|
  # $timeout = 1000
  Capybara.default_max_wait_time = 0

  #
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

  Capybara.register_driver :selenium_ie do |app|
    Capybara::Selenium::Driver.new(app, :browser => :ie)
  end


  Capybara.register_driver :selenium_chrome do |app|

    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 600

    Capybara::Selenium::Driver.new(app, :browser => :chrome, :http_client => client,
                                   desired_capabilities: {
                                       "chromeOptions" => {
                                           "args" => %w{ window-size=1580,1024 }
                                       }
                                   }
    )
  end

  capybara.default_driver = :selenium_chrome
  capybara.run_server = false

  After do |scenario|
    if(scenario.failed?)
      $feature_name = 'screenshot'
      t = Time.now
      page.driver.browser.save_screenshot("reports/#{$feature_name}.png")
      embed("#{$feature_name}.png", "image/png", "SCREENSHOT")
      puts "reports/#{$feature_name}_#{t.strftime('%H-%M-%S')}.png"
    end
  end

end








