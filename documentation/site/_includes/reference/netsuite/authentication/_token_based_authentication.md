## Overview

In order to authenticate to NetSuite, you need the following:

- `account_id`
- `consumer_key`
- `consumer_secret`
- `token_id`
- `token_secret`

We will walk through how to get each value in the following sections.

<div class="note"><strong>Note:</strong>
You need to have sufficient permissions to set up your account for API authentication.
</div>

## Prerequisites

### REST Web Services feature

Enable the feature at Setup > Company > Setup Tasks > Enable Features, in the SuiteTalk (Web Services) section, on the SuiteCloud subtab. To use the feature, you must accept the SuiteCloud Terms of Service.

### SuiteAnalytics Workbook feature

Enable the feature at Setup > Company > Setup Tasks > Enable Features, on the Analytics subtab.

### Permissions

You will require the following permissions:

- REST Web Services
- Log in using Access Tokens
- SuiteAnalytics Workbook

Your permissions vary based on which role you are assigned.  You can edit roles in Setup > Users/Roles > User Management > Manage Roles.  Ensure your user is assigned a role with the aforementioned permissions in order to complete the setup.

<div class="note"><strong>Note:</strong>
<p>
  There are two different sets of permissions you will need:
</p>
<p>
  <ul>
    <li>The permissions mentioned above are to <strong>set up</strong> your integration.</li>
    <li>Later when creating a token, you will need to assign a user with a role that has the necessary permissions to <strong>access records</strong> (e.g. payments, invoices, bills, etc.)</li>
  </ul>
</p>

<p>
These can be the same or different roles.  They can be assigned to one or many users.
</p>
</div>

## Account ID

The `account_id` can be found in the URL when you are logged into the NetSuite dashboard in your browser.  It will look
something like the following:

```
https://<account_id>.app.netsuite.com/app/center/card.nl?sc=-29&whence=
```

Example:

```
https://123456.app.netsuite.com/app/center/card.nl?sc=-29&whence=
```

The Account ID precedes `.app.netsuite.com`, which in this case is `123456`.  Note that your ID may include `-sb1`
(representing "Sandbox 1").  Be sure to include the entire ID as it appears in the URL, including any letters, numbers,
and hyphens.

## Consumer Keys

The consumer keys are retrieved when you [create an Integration record](https://system.netsuite.com/app/help/helpcenter.nl?fid=bridgehead_4249032125.html&whence=).  You can view [the NetSuite documentation](https://system.netsuite.com/app/help/helpcenter.nl?fid=bridgehead_4249032125.html&whence=) for the official documentation.

At the last step of creating an Integration record, save the consumer key and consumer secret.  They will not be shown again once you navigate away from the page.

## Token

To obtain your `token_key` and `token_secret`, you will need to [create a Token](https://system.netsuite.com/app/help/helpcenter.nl?fid=bridgehead_4254081947.html).  View [the NetSuite documentation](https://system.netsuite.com/app/help/helpcenter.nl?fid=bridgehead_4254081947.html) for the official documentation.

You will use the integration record you created along with your user (or the user who has the necessary permissions to access records).

At the last step, save the token key and token secret.

## Conclusion

Now with these values, you can successfully authenticate to NetSuite.  Simply pass the values into the client:

{% highlight ruby linenos %}
client = LedgerSync::Ledgers::QuickBooksOnline::Client.new(
  account_id: account_id,
  consumer_key: consumer_key,
  consumer_secret: consumer_secret,
  token_id: token_id,
  token_secret: token_secret
)
{% endhighlight %}

