require 'httparty'
require 'debug'

# Provide authentication credentials
access_token = ENV["DEPENDABOT_REPORTER_TOKEN"]

results = HTTParty.get(
  "https://api.github.com/orgs/pulibrary/dependabot/alerts?per_page=2",
  # query: {
  #   # state: "open",
  #   per_page: 100
  # },
  headers: {
    "Accept" => "application/vnd.github+json",
    "Authorization" => "Bearer #{access_token}",
    "X-GitHub-Api-Version" => "2022-11-28"
  }
)

puts results.map{ |h| {url: h["url"], state: h["state"]}}
puts results.length 