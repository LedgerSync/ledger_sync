# frozen_string_literal: true

require 'spec_helper'

# Ref: https://5743578-sb1.app.netsuite.com/app/help/helpcenter.nl?fid=section_1534941088.html
RSpec.describe LedgerSync::Adaptors::NetSuiteREST::Token do
  let(:expected_signature_data_string) { 'POST&https%3A%2F%2F1234567.restlets.api.netsuite.com%2Fapp%2Fsite%2Fhosting%2Frestlet.nl&customParam%3DsomeValue%26deploy%3D1%26oauth_consumer_key%3Def40afdd8abaac111b13825dd5e5e2ddddb44f86d5a0dd6dcf38c20aae6b67e4%26oauth_nonce%3DfjaLirsIcCGVZWzBX0pg%26oauth_signature_method%3DHMAC-SHA256%26oauth_timestamp%3D1508242306%26oauth_token%3D2b0ce516420110bcbd36b69e99196d1b7f6de3c6234c5afb799b73d87569f5cc%26oauth_version%3D1.0%26script%3D6%26testParam%3DsomeOtherValue' }

  let(:account_id) { '1234567' }
  let(:body) { nil }
  let(:consumer_key) { 'ef40afdd8abaac111b13825dd5e5e2ddddb44f86d5a0dd6dcf38c20aae6b67e4' }
  let(:consumer_secret) { 'd26ad321a4b2f23b0741c8d38392ce01c3e23e109df6c96eac6d099e9ab9e8b5' }
  let(:method) { 'POST' }
  let(:nonce) { 'fjaLirsIcCGVZWzBX0pg' }
  let(:token_id) { '2b0ce516420110bcbd36b69e99196d1b7f6de3c6234c5afb799b73d87569f5cc' }
  let(:token_secret) { 'c29a677df7d5439a458c063654187e3d678d73aca8e3c9d8bea1478a3eb0d295' }
  let(:timestamp) { '1508242306' }
  let(:url) { 'https://1234567.restlets.api.netsuite.com/app/site/hosting/restlet.nl?script=6&deploy=1&customParam=someValue&testParam=someOtherValue' }

  let(:token) do
    described_class.new(
      body: body,
      consumer_key: consumer_key,
      consumer_secret: consumer_secret,
      method: method,
      nonce: nonce,
      token_id: token_id,
      token_secret: token_secret,
      timestamp: timestamp,
      url: url
    )
  end

  context 'https://tools.ietf.org/html/rfc5849' do
    let(:body) do
      {
        c2: nil,
        'a3' => '2 q'
      }
    end
    let(:consumer_key) { '9djdj82h48djs9d2' }
    let(:method) { 'post' }
    let(:nonce) { '7d8f3e4a' }
    let(:token_id) { 'kkk9d7dh3k39sjv7' }
    let(:timestamp) { '137131201' }
    let(:url) { 'https://example.com/request?b5=%3D%253D&a3=a&c%40=&a2=r%20b' }

    describe '#sorted_encoded_parameters' do
      it do
        params = [
          ['a2', 'r%20b'],
          ['a3', '2%20q'],
          ['a3', 'a'],
          ['b5', '%3D%253D'],
          ['c%40', ''],
          ['c2', ''],
          ['oauth_consumer_key', '9djdj82h48djs9d2'],
          ['oauth_nonce', '7d8f3e4a'],
          ['oauth_signature_method', 'HMAC-SHA256'],
          ['oauth_timestamp', '137131201'],
          ['oauth_token', 'kkk9d7dh3k39sjv7'],
          ['oauth_version', '1.0']
        ]
        expect(token.send(:sorted_encoded_parameters)).to eq(params)
      end
    end

    describe '#parameters_string' do
      it do
        s = 'a2=r%20b&a3=2%20q&a3=a&b5=%3D%253D&c%40=&c2=&oauth_consumer_key=9djdj82h48djs9d2&oauth_nonce=7d8f3e4a&oauth_signature_method=HMAC-SHA256&oauth_timestamp=137131201&oauth_token=kkk9d7dh3k39sjv7&oauth_version=1.0'
        expect(token.send(:parameters_string)).to eq(s)
      end
    end

    describe '#signature_data_string' do
      it do
        s = 'POST&https%3A%2F%2Fexample.com%2Frequest&a2%3Dr%2520b%26a3%3D2%2520q%26a3%3Da%26b5%3D%253D%25253D%26c%2540%3D%26c2%3D%26oauth_consumer_key%3D9djdj82h48djs9d2%26oauth_nonce%3D7d8f3e4a%26oauth_signature_method%3DHMAC-SHA256%26oauth_timestamp%3D137131201%26oauth_token%3Dkkk9d7dh3k39sjv7%26oauth_version%3D1.0'
        expect(token.send(:signature_data_string)).to eq(s)
      end
    end
  end

  context 'https://oauth.net/core/1.0a/ Appendix A.5.1' do
    let(:body) do
      {
        file: 'vacation.jpg',
        'size' => :original
      }
    end
    let(:consumer_key) { 'dpf43f3p2l4k3l03' }
    let(:method) { :get }
    let(:nonce) { 'kllo9940pd9333jh' }
    let(:token_id) { 'nnch734d00sl2jdk' }
    let(:timestamp) { '1191242096' }
    let(:url) { 'http://photos.example.net/photos' }

    describe '#signature_data_string' do
      it do
        s = 'GET&http%3A%2F%2Fphotos.example.net%2Fphotos&file%3Dvacation.jpg%26oauth_consumer_key%3Ddpf43f3p2l4k3l03%26oauth_nonce%3Dkllo9940pd9333jh%26oauth_signature_method%3DHMAC-SHA256%26oauth_timestamp%3D1191242096%26oauth_token%3Dnnch734d00sl2jdk%26oauth_version%3D1.0%26size%3Doriginal'
        expect(token.send(:signature_data_string)).to eq(s)
      end
    end
  end

  describe '#signature' do
    it do
      allow(token).to receive(:signature_data_string) { expected_signature_data_string }
      expect(token.signature).to eq('i7MEtGwhCTIZbTsTrNGw9LdcERn4wsjt5C7TxmKWIfU=')
    end

    it do
      expect(token.signature).to eq('i7MEtGwhCTIZbTsTrNGw9LdcERn4wsjt5C7TxmKWIfU=')
    end
  end

  describe '#signature_data_string' do
    it do
      expect(token.signature_data_string).to eq(expected_signature_data_string)
    end
  end

  describe '#signature_key' do
    it do
      expect(token.signature_key).to eq("#{consumer_secret}&#{token_secret}")
    end
  end
end
