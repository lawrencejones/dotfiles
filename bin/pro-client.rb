gem 'gocardless-pro', '~>0.3.0'
require 'gocardless-pro'

class GCEnv
  def self.ask(env=nil)
    until env && env.match(/(sandbox|live)-(staging|production)/)
      print "Enter GoCardless env: "
      env = gets.chomp
    end
    self.new(env)
  end

  def initialize(env)
    @env = env
  end

  def client
    @client ||= GoCardless::Client.new(
      environment: sym_env,
      url: api_url,
      token: token,
      version: '2015-04-29'
    )
  end

  def sym_env
    @env.split('-').first.to_sym
  end

  def api_url
    "https://#{domain}.gocardless.com"
  end

  def domain
    {
      'live-production' => 'api',
      'sandbox-production' => 'api-sandbox',
      'live-staging' => 'api-staging',
      'sandbox-staging' => 'api-sandbox-staging',
    }.fetch(@env)
  end

  def is_production
    @env.split('-').second == 'production'
  end

  def token
    ENV.fetch("GC_ACCESS_TOKEN_#{@env.gsub('-', '_').upcase}")
  end

  def to_s
    @env
  end
end

env = GCEnv.ask

puts "Loaded GC Version [#{GoCardless::VERSION}]"
puts "Connection to env: #{env}"
$client = env.client
