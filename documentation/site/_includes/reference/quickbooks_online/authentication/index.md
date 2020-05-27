---
title: Authentication
layout: reference_quickbooks_online
ledger: quickbooks_online
---

### OAuth

QuickBooks Online utilizes OAuth 2.0, which requires frequent refreshing of the access token.  The client will handle this automatically, attempting a single token refresh on any single request authentication failure.  Depending on how you use the library, every client has implements a class method `ledger_attributes_to_save`, which is an array of attributes that may change as the client is used.  You can also call the instance method `ledger_attributes_to_save` which will be a hash of these values.  It is a good practice to always store these attributes if you are saving access tokens in your database.

#### Retrieve Access Token

The library contains a lightweight script that is helpful in retrieving and refreshing access tokens.  To use, do the following:

1. Create a `.env` file in the library root.
2. Add values for `QUICKBOOKS_ONLINE_CLIENT_ID` and `QUICKBOOKS_ONLINE_CLIENT_SECRET` (you can copy `.env.template`).
3. Ensure your developer application in [the QuickBooks Online developer portal](https://developer.intuit.com) contains this redirect URI: `http://localhost:5678` (note: no trailing slash and port configurable with `PORT` environment variable)
4. Run `ruby bin/quickbooks_online_oauth_server.rb` from the library root (note: it must run from the root in order to update `.env`).
5. Visit the URL output in the terminal.
6. Upon redirect back to your `localhost`, the new values will be printed to the console and saved back to your `.env`

#### Ledger Helper Methods

The client also implements some helper methods for getting tokens.  For example, you can set up an client using the following:

```ruby
# Retrieve the following values from Intuit app settings
client_id     = 'ID'
client_secret = 'SECRET'
redirect_uri  = 'http://localhost:3000'

oauth_client = LedgerSync::Ledgers::QuickBooksOnline::OAuthClientHelper.new(
  client_id: client_id,
  client_secret: client_secret
)

puts oauth_client.authorization_url(redirect_uri: redirect_uri)

# Visit on the output URL and authorize a company.
# You will be redirected back to the redirect_uri.
# Copy the full url from your browser:

uri = 'https://localhost:3000/?code=FOO&state=BAR&realm_id=BAZ'

client = LedgerSync::Ledgers::QuickBooksOnline::Client.new_from_oauth_client_uri(
  oauth_client: oauth_client,
  uri: uri
)

# You can test that the auth works:

client.refresh!
```

**Note: If you have a `.env` file storing your secrets, the client will automatically update the variables and record previous values whenever values change**