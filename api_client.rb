require 'octokit'

# Provide authentication credentials
client = Octokit::Client.new(:access_token => ENV["DEPENDABOT_REPORTER_TOKEN"])

# You can still use the username/password syntax by replacing the password value with your PAT.
# client = Octokit::Client.new(:login => 'defunkt', :password => 'personal_access_token')

# Fetch the current user
client.user