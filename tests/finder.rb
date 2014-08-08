# include class of particular page: Google
require './pages/google'

# start the test
# create GooglePage object
page = GooglePage.new(:firefox)

# perform search for a search term
page.search 'Tottenham court road'

# perform search in the results of basic search
# for a search term
page.search_in_results 'Tottenham Court Road - Wasabi'

# check page title whether it has required value
page.check_page 'Wasabi'

# retrieve results
page.get_results

# finish the test
page.exit