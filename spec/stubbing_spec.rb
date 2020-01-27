# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'stubbing' do
  let(:method) { :post }
  let(:url) { 'https://example.com' }
  let(:body) do
    {
      a: 1,
      b: 2
    }
  end
  let(:headers) do
    {
      'Accept' => '*/*',
      'Content-Type' => 'application/json'
    }
  end

  it do
    stub_request(method, url, times: nil)
      .with(
        body: body.to_json,
        headers: headers
      )
    response = Faraday.send(method, url) do |req|
      req.headers = headers
      req.body = body.to_json
    end
    expect(response.status).to eq(200)
  end

  it do
    stub_request(method, url, times: nil)
      .with(
        body: body,
        headers: headers
      )

    response = Faraday.send(method, url) do |req|
      req.headers = headers
      req.body = body.to_json
    end
    expect(response.status).to eq(200)
  end

  it do
    stub_request(method, url, times: nil)
      .with(
        body: '{"a":1,"b":2}',
        headers: headers
      )

    response = Faraday.send(method, url) do |req|
      req.headers = headers
      req.body = body.to_json
    end
    expect(response.status).to eq(200)
  end

  it do
    stub_request(method, url, times: nil)
      .with(
        body: '{"b":2,"a":1}',
        headers: headers
      )

    expect do
      Faraday.send(method, url) do |req|
        req.headers = headers
        req.body = body.to_json
      end
    end.to raise_error(WebMock::NetConnectNotAllowedError)
  end
end
