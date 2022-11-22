# dependabot-reporter
Retrieve dependabot information across the PUL organization.

# Repository Permissions

When selecting Github repository permissions (read-write-edit) for this repo, we enabled the following permissions: 

> Dependabot alerts (read only)

> Security events (read only)

> Metadata (read only)

With these permissions enabled this will allow the user to view and retrieve security and dependencies alerts from multiple repositories across Github. 

# Personal Authorization Token creation

You will need to create a Personal Access Token (which can be found in your personal settings > Developer settings > select Fine-Grained tokens) which should then be added to your z-shell (~/.zshrc) config file:

```export DEPENDABOT_REPORTER_TOKEN='generated token'```

Once you have obtained this token and added it into your z-shell config, you will need to source the ~/.zshrc file for the changes to take effect. 

```source ~/.zshrc```

