require 'httparty'
require 'debug'

# Provide authentication credentials

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
  next_page_url = get_next_page_url(response.headers["Link"])
  [response, next_page_url]
end

def get_next_page_url(link_header)
  next_link_tuple = link_header.split(", ").map do |entry|
    entry.split("; ")
  end.find do |tuple|
    tuple.last.match?("next")
  end
  return unless next_link_tuple
  next_link_tuple.first[1..-2]
end


data = []
next_url = "https://api.github.com/orgs/pulibrary/dependabot/alerts?state=open"

while next_url do
  results, next_url = get_page_of_results(next_url)
  # puts results.map{ |h| {url: h["url"], state: h["state"]}}
  data.concat(results.parsed_response)
end

# data now has all the alerts!
# Next time: let's make this a class. let's maybe add some tests.

# pagenate through the alerts, default is 30 per page and we haven't
# successfully used per_page to get more than that.
#
# get the first page of results. There's gonna be a curser in the
# responser "Link" header
#
# Link headers are pre-parsed for you and come through as an array of [url,
# options] tuples.
# Link: <url1>; rel="next", <url2>; rel="foo"; bar="baz"

# actual link header example:
# "<https://api.github.com/organizations/1827800/dependabot/alerts?state=open&after=Y3Vyc29yOnYyOpHOwHcA5w%3D%3D>; rel=\"next\", <https://api.github.com/organizations/1827800/dependabot/alerts?state=open&before=Y3Vyc29yOnYyOpHOw1JkIw%3D%3D>; rel=\"prev\""

# get the first page
# get the data from the first page and store it in a variable
# get the url for the next page
#
# get the next page
# get the data from that page and add it the data variable
# get the url for the next page
#
# get the next page
# get the data from that page and add it to the data variable
# get the url for the next page
#
#...
#
# get the last page
# get the data from the last page
# somehow figure out there's another url. stop.
