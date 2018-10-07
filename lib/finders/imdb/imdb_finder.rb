class IMDBFinder < BaseFinder
  SITE_URL = 'https://www.imdb.com/'

  def search_process
    button_path = "//button[@id='navbar-submit-button']"
    fill_in 'q', with: @search_request
    find(:xpath, button_path).click
  end

  def data_collection
    data = []
    return data if has_text? 'No results found'

    click_link 'More keyword matches'
    header_path = "h3[@class='lister-item-header']"
    title_path = "#{header_path}/a"
    year_path = "#{header_path}/span[contains(@class, 'lister-item-year')]"
    genres_path = "p/span[@class='genre']"
    rating_path = "div[@class='ratings-bar']/div[contains(@class, "\
      "'ratings-imdb-rating')]/strong"
    for_each_keyword do
      for_each_page do
        get_items.each do |item|
          title = item.first(:xpath, title_path).text
          genres = find_or_nil(genres_path, item)&.text
          rating = find_or_nil(rating_path, item)&.text
          year = find_or_nil(year_path, item)&.text&.gsub(/[\(\)]/, '')
          data << { title: title, genres: genres, rating: rating, year: year }
        end
      end
    end
    data
  end

  private

  def for_each_page
    begin
      assert_no_selector(
        :xpath,
        "//div[contains(@class, 'lister-working')]",
        wait: 10
      )
      yield
      next_button = find_or_nil("//a[contains(., 'Next')]", first: true)
    end while next_button&.public_send(:click)
  end

  def for_each_keyword
    path = "//tr[contains(@class, 'findResult')]/td/a"
    links = all(:xpath, path).map { |link| link[:href] }
    links.each do |link|
      visit link
      yield
    end
  end

  def get_items
    path = "//div[@class='lister-item-content']"
    all(:xpath, path)
  end

  def find_or_nil(path, item = nil, first: false)
    procedure = first ? :first : :find
    return item.public_send(procedure, :xpath, path) if item

    public_send(procedure, :xpath, path)
  rescue Capybara::ElementNotFound, Capybara::ExpectationNotMet
    nil
  end
end
