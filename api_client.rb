require 'httparty'

# Provide authentication credentials
access_token = ENV["DEPENDABOT_REPORTER_TOKEN"]

HTTParty.get("https://api.github.com/repos/pulibrary/figgy/dependabot/alerts", headers: {"Accept" => "application/vnd.github+json", "
Authorization" => "Bearer #{access_token}", "X-GitHub-Api-Version" => "2022-11-28"})