# frozen_string_literal: true

# Setup
#
# gem install bundler
# Ensure you have http://localhost:5678 (or PORT) as a Redirect URI in QBO.

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'dotenv'
  gem 'ledger_sync'
  gem 'ledger_sync-xero', path: '../'
  gem 'rack'
  gem 'pd_ruby'
end

puts 'Gems installed and loaded!'

require 'pd_ruby'
require 'socket'
require 'dotenv'
require 'rack'
require 'ledger_sync'
require 'rack/lobster'
Dotenv.load

port = ENV.fetch('PORT', 5678)
server = TCPServer.new(port)

base_url = "http://localhost:#{port}"

puts "Listening at #{base_url}"

client_id = ENV.fetch('CLIENT_ID')

raise 'CLIENT_ID not set in ../.env' if client_id.blank?

client = LedgerSync::Ledgers::Xero::Client.new_from_env

puts 'Go to the following URL:'
puts client.authorization_url(redirect_uri: base_url)

while (session = server.accept)
  request = session.gets

  puts request

  # 1
  _method, full_path = request.split(' ')

  # 2
  _path, query = full_path.split('?')

  params = Hash[query.split('&').map { |e| e.split('=') }] if query.present?

  client.set_credentials_from_oauth_code(
    code: params.fetch('code'),
    redirect_uri: base_url
  )

  puts "\n"

  puts 'access_token:'
  puts client.access_token
  puts ''
  puts 'client_id:'
  puts client.client_id
  puts ''
  puts 'client_secret:'
  puts client.client_secret
  puts ''
  puts 'refresh_token:'
  puts client.refresh_token
  puts ''
  puts 'expires_at:'
  puts Time&.at(client.oauth.expires_at.to_i)&.to_datetime
  puts ''
  puts 'tenants:'
  client = LedgerSync::Ledgers::Xero::Client.new_from_env
  client.tenants.each do |t|
    puts "#{t['tenantName']} (#{t['tenantType']}) - #{t['tenantId']}"
  end
  puts ''
  puts 'Done!'

  status = 200
  body = 'Done'
  headers = {
    'Content-Length' => body.size
  }

  session.print "HTTP/1.1 #{status}\r\n"

  headers.each do |key, value|
    session.print "#{key}: #{value}\r\n"
  end

  session.print "\r\n"

  session.print body

  session.close

  break
end
