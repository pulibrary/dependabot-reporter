require 'httparty'
require 'debug'

# get a page of results. The api returns a pagenation cursor in the Link header
# @param url [String] the url for the page to fetch
# @return Array[Array, String] a tuple containing the data and the url to fetch
#   the next page
def get_page_of_results(url)
  access_token = ENV["DEPENDABOT_REPORTER_TOKEN"]
  response = HTTParty.get(
    url,
    headers: {
      "Accept" => "application/vnd.github+json",
      "Authorization" => "Bearer #{access_token}",
      "X-GitHub-Api-Version" => "2022-11-28"
    }
  )
  next_page_url = parse_next_page_url(response.headers["Link"])
  [response, next_page_url]
end

# @param link_header [String] in the form of "Link: <url1>; rel=\"next\", <url2>; rel=\"prev\""
# actual link header example:
# "<https://api.github.com/organizations/1827800/dependabot/alerts?state=open&after=Y3Vyc29yOnYyOpHOwHcA5w%3D%3D>; rel=\"next\", <https://api.github.com/organizations/1827800/dependabot/alerts?state=open&before=Y3Vyc29yOnYyOpHOw1JkIw%3D%3D>; rel=\"prev\""
def parse_next_page_url(link_header)
  # The string becomes an array of 2 strings:
  #   ["Link: <url1>; rel=\"next\"", "<url2>; rel=\"prev\""]
  link_headers_array = link_header.split(", ")
  # slit each string in link_headers array into another array, so now we have an
  #   array of tuples:
  #   [["Link: <url1>", "rel=\"next\""], ["<url2>", "rel=\"prev\""]]
  link_header_tuples = link_headers_array.map do |entry|
    entry.split("; ")
  end
  # get just the tuple which has rel=next
  next_link_tuple = link_header_tuples.find do |tuple|
    tuple.last.match?("next")
  end
  return unless next_link_tuple
  # the first item in that tuple is the url
  url = next_link_tuple.first
  # strip the angle brackets from the url and return
  url[1..-2]
end


# pagenate through the alerts, default is 30 per page and we haven't
# successfully used per_page to get more than that.
data = []
next_url = "https://api.github.com/orgs/pulibrary/dependabot/alerts?state=open"

while next_url do
  results, next_url = get_page_of_results(next_url)
  # puts results.map{ |h| {url: h["url"], state: h["state"]}}
  data.concat(results.parsed_response)
end

# data now has all the alerts!
# Next time: let's make this a class. let's maybe add some tests.

puts data.count
