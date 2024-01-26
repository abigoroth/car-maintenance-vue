module WorkshopScraper
  extend ActiveSupport::Concern

  class_methods do
    def start_scrape

      options = Selenium::WebDriver::Options.chrome
      options.accept_insecure_certs=true
      driver = Selenium::WebDriver.for :chrome, options: options
      driver.navigate.to 'https://www.google.com.my/maps/place/@3.0776741,101.4621354,12z/'
      # Search for workshop
      input = driver.find_element("tag_name", "input")
      input.send_keys 'workshop'
      input.send_keys(:enter)

      # Wait for search to complete
      wait = Selenium::WebDriver::Wait.new
      wait.until { driver.find_element("xpath", "//div[@role='feed']")  }
      feedDiv = driver.find_element("xpath", "//div[@role='feed']")
      100.times{ |x| feedDiv.send_keys(:arrow_down) }
      directionBtns = feedDiv.find_elements("xpath", "//button[contains(., 'Directions')]")
      directionBtns.each do |btn|
        text = btn.find_element("xpath", '../../..').text
        arr = text.split("\n")
        company_name = arr[0]
        business,address = arr[2].split("·")
        phone = arr[3].split("·")[-1]
        rating = arr[1]

        location = btn.find_element("xpath", '../../../../..').find_element("tag_name", "a").attribute("href")
        workshop = Workshop.find_or_initialize_by(name: company_name)
        workshop.business = business
        workshop.address = address
        workshop.phone = phone
        workshop.rating = rating
        workshop.save

      end
      # binding.pry
    end
  end
end
