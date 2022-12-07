# dependabot-reporter
Retrieve dependabot information across the PUL organization.

# Personal Authorization Token creation

You will need to create a Personal Access Token, which can be found in your personal settings > Developer settings > Tokens (classic). Generate a new token (classic) and give it the "repo" scope. No other scopes need to be selected. Add the token to your z-shell (~/.zshrc) config file:

```export DEPENDABOT_REPORTER_TOKEN='generated token'```

Once you have obtained this token and added it into your z-shell config, you will need to source the ~/.zshrc file for the changes to take effect. 

```source ~/.zshrc```
