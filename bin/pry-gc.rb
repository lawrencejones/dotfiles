gem 'gocardless-pro', '~>0.2.0'
require 'gocardless-pro'

puts "Loaded GC Version [#{GoCardless::VERSION}]"
$client = GoCardless::Client.new(
  environment: :sandbox,
  url: 'https://api-sandbox-staging.gocardless.com',
  token: ENV['GC_ACCESS_TOKEN'],
  version: '2015-04-29'
)
