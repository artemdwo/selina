# include basic Page class
require './pages/page'

class GooglePage < Page

  # page number counter
  @@page_number = 1

  # search term storage
  @@search_term = ''

  # trigger to point whether search term was found
  @@found = false

  # result message
  @@result = ''

  # method serves search functionality of the GooglePage
  def search(basic_search_term = '')
    # open http://www.google.co.uk
    @driver.navigate.to 'http://www.google.co.uk'

    # find search field element
    search_field = @driver.find_element(:name,'q')

    # put basic_search_term into the field
    search_field.send_keys(basic_search_term)

    # find search button
    search_button = @driver.find_element(:name,'btnG')

    # click on the search_button
    search_button.click

    # wait result to load
    sleep(2)
  end

  # method serves search functionality
  # inside the results on the GooglePage
  def search_in_results(additional_search_term = @@search_term)
    # find all result elements
    elements = @driver.find_elements(:css,'h3>a')

    # search for the requested term inside
    # the results.
    # if additional_search_term is on the page
    # then click on it, save success message and set found trigger into true
    elements.each do |el|
      if el.text == additional_search_term
        el.click
        @@result = "The request '#{@@search_term}' was found on #{@@page_number} page"
        @@found = true
      end
    end

    # in case if current page doesn't contain additional_search_term
    # (found trigger is false)
    # switch to the next result page
    unless @@found
      @@search_term = additional_search_term
      next_page()
    end
  end

  # method server getting the resutls
  def get_results
    puts @@result
  end

  # supplementary method to switch between
  # search result pages
  # private, because in this case should server only this class
  private
  def next_page()
    # increment page_number (the test started from the 1ts)
    @@page_number += 1

    # search for the paginator on the GooglePage
    # and retrieve all available pages
    pagination = @driver.find_elements(:css,'tbody>tr>td>a')

    # search for the requested page number
    # if page_number is available
    # then click on it set proceed trigger into true
    pagination.each do |page|
      if page.text == @@page_number.to_s
        page.click
        @proceed = true
      end
    end

    # if switching was success (proceed trigger is true)
    # then continue to search_in_results
    # in case if paginator doesn't have requested page_number (proceed trigger is false or nil)
    # then save result message and skip search_in_results
    if @proceed
      @proceed = false
      sleep(2)
      search_in_results()
    else
      @@result = "There is no results for the request: #{@@search_term}"
    end
  end
end