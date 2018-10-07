class BaseFinder
  include Capybara::DSL

  MANDATORY_METHODS = [:search_process, :data_collection]
  FIELDS = [:title, :genres, :rating, :year]

  def initialize(search_request)
    Capybara.current_driver = driver
    @search_request = search_request
  end

  def visit_site
    visit self.class::SITE_URL
  end

  def data
    { fields: self.class::FIELDS, movies: data_collection, copyright: copyright }
  end

  def copyright
    "Data is provided by #{self.class::SITE_URL}"
  end

  def headless?
    true
  end

  def driver
    return :selenium_chrome_headless if headless?

    :selenium_chrome
  end

  MANDATORY_METHODS.each do |method_name|
    define_method(method_name) { raise NotImplementedError }
  end
end
