# frozen_string_literal: true

module NetSuiteHelpers
  def netsuite_adaptor
    adaptors.netsuite.new(**netsuite_adaptor_args)
  end

  def netsuite_adaptor_args
    {
      account_id: 'account_id',
      api_version: '2016_2',
      consumer_key: 'consumer_key',
      consumer_secret: 'consumer_secret',
      token_id: 'token_id',
      token_secret: 'token_secret'
    }
  end

  def stub_customer_create
    stub_request(:get, "https://account_id.suitetalk.api.netsuite.com/wsdl/v2016_2_0/netsuite.wsdl")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '<env:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:platformMsgs="urn:messages_2016_2.platform.webservices.netsuite.com" xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:platformCore="urn:core_2016_2.platform.webservices.netsuite.com">
        <env:Header>
          <platformMsgs:tokenPassport>
            <platformCore:account>5743578_SB1</platformCore:account>
            <platformCore:consumerKey>***FILTERED***</platformCore:consumerKey>
            <platformCore:token>***FILTERED***</platformCore:token>
            <platformCore:nonce>h4F8rTdFfhzMjAXkkY85</platformCore:nonce>
            <platformCore:timestamp>1574763721</platformCore:timestamp>
            <platformCore:signature algorithm="HMAC-SHA256">BBoas7iHQ0qxiZ2XvClwYypI1uFiJZuXuqnp5fnWxAE=
      </platformCore:signature>
          </platformMsgs:tokenPassport>
        </env:Header>
        <env:Body>
          <platformMsgs:get>
            <platformMsgs:baseRef xsi:type="platformCore:RecordRef" internalId="521" type="customer"/>
          </platformMsgs:get>
        </env:Body>
      </env:Envelope>', headers: {})
  end
end
