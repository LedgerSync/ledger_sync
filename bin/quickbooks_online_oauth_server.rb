# Setup
#
# gem install bundler
# Ensure you have http://localhost:5678 (or PORT) as a Redirect URI in QBO.

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'dotenv'
  gem 'ledger_sync'
  gem 'rack'
  gem 'pd_ruby', '0.2.2', require: true
end

puts 'Gems installed and loaded!'

require 'socket'
require 'dotenv'
require 'rack'
require 'ledger_sync'
require 'rack/lobster'

Dotenv.load

port = ENV.fetch('PORT', 5678)
app = Rack::Lobster.new
server = TCPServer.new port

base_url = "http://localhost:#{port}"

puts "Listening at #{base_url}"

client_id = ENV.fetch('QUICKBOOKS_ONLINE_CLIENT_ID')

raise 'QUICKBOOKS_ONLINE_CLIENT_ID not set in ../.env' if client_id.blank?

client = LedgerSync::Ledgers::QuickBooksOnline::Client.new_from_env(test: true)

puts 'Go to the following URL:'
puts client.authorization_url(redirect_uri: base_url)

while session = server.accept
  request = session.gets

  puts request

  # 1
  method, full_path = request.split(' ')

  # 2
  path, query = full_path.split('?')

  params = Hash[query.split('&').map { |e| e.split('=') }] if query.present?

  client.set_credentials_from_oauth_code(
    code: params.fetch('code'),
    realm_id: params.fetch('realmId'),
    redirect_uri: base_url
  )

  puts "\n"

  puts 'access_token:'
  puts client.access_token
  puts "\n"
  puts 'client_id:'
  puts client.client_id
  puts "\n"
  puts 'client_secret:'
  puts client.client_secret
  puts "\n"
  puts 'realm_id:'
  puts client.realm_id
  puts "\n"
  puts 'refresh_token:'
  puts client.refresh_token
  puts "\n"

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
