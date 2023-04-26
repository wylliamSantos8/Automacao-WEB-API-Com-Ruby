require "capybara"
require "capybara/cucumber"
require "faker"
require "allure-cucumber"

CONFIG = YAML.load_file(File.join(Dir.pwd, "features/support/config/#{ENV["CONFIG"]}"))

BROWSER = ENV["BROWSER"]

case ENV["BROWSER"]
when "firefox"
  @driver = :selenium
when "chrome"
  @driver = :selenium_chrome
when "fire_headless"
  @driver = :selenium_headless
when "chrome_headless"
  Capybara.register_driver :selenium_chrome_headless do |app|
    Capybara::Selenium::Driver.load_selenium
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.args << "--headless"
      opts.args << "--disable-gpu" if Gem.win_platform?
      opts.args << "--disable-site-isolation-trials"
      opts.args << "--no-sandbox"
      opts.args << "--disable-dev-shm-usage"
    end
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
  end
  @driver = :selenium_chrome_headless
else
  raise "Navegador incorreto, variável @driver está vazia :("
end

Capybara.configure do |config|
  config.default_driver = @driver #define o chrome como navegador de execução
  config.app_host = CONFIG["url"] #propriedade para definir a URl padrão do sistema
  config.default_max_wait_time = 10 #define o tempo para encontrar elemento na tela
end

AllureCucumber.configure do |config|
  config.results_directory = "/logs"
  config.clean_results_directory = true
end
