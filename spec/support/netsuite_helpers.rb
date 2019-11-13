# frozen_string_literal: true

module NetSuiteHelpers
  def netsuite_adaptor
    adaptors.netsuite.new(**netsuite_adaptor_args)
  end

  def netsuite_adaptor_args
    {
      account: 'account',
      application_id: 'application_id',
      consumer_key: 'consumer_key',
      consumer_secret: 'consumer_secret',
      token_id: 'token_id',
      token_secret: 'token_secret'
    }
  end

  def stub_customer_create
    stub_request(:get, 'https://.suitetalk.api.netsuite.com/wsdl/v2016_2_0/netsuite.wsdl')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '<soapenv:Body>
        <addResponse xmlns="urn:messages_2017_1.platform.webservices.netsuite.com">
        <writeResponse xmlns="urn:messages_2017_1.platform.webservices.netsuite.com">
           <ns1:status isSuccess="true" xmlns:ns1="urn:core_2017_1.platform.webservices.netsuite.com"/>
              <baseRef internalId="123" type="customer" xsi:type="ns2:RecordRef"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xmlns:ns2="urn:core_2017_1.platform.webservices.netsuite.com"/>
        </writeResponse>
        </addResponse>
        </soapenv:Body>', headers: {})
  end
end
