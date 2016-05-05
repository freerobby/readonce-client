require_relative 'readonce/version'

require 'httparty'

class ReadOnce
  include HTTParty
  BASE_URI = 'https://readonce-production.herokuapp.com'
  USER_AGENT_HEADER = {'User-Agent' => "ReadOnce Gem/#{Readonce::VERSION}"}
  base_uri BASE_URI

  def self.exit_if_gem_outdated!
    response = get '/minimum-ruby-client-version', headers: USER_AGENT_HEADER
    major, minor, patch = response.body.split('.').map{|m| m.to_i}

    if Readonce::MAJOR_VERSION < major || Readonce::MINOR_VERSION < minor || Readonce::PATCH_VERSION < patch
      required_version = "#{major}.#{minor}.#{patch}"
      puts "ERROR: Gem version is #{Readonce::VERSION}, but #{required_version} or later is now required."
      puts 'Please run: gem install readonce'
      exit
    end
  end

  def self.from_key(key)
    r = ReadOnce.new
    r.instance_variable_set(:@key, key)
    r
  end

  def self.from_data(data)
    self.class.exit_if_gem_outdated!
    response = post '/create', body: data, headers: {'Content-type' => 'text/plain'}.merge(USER_AGENT_HEADER)
    r = ReadOnce.new
    r.instance_variable_set(:@key, response.body)
    r
  end

  def read_url
    "#{BASE_URI}/#{key}"
  end

  def read?
    self.class.exit_if_gem_outdated!
    response = self.class.get "/status/#{key}", headers: USER_AGENT_HEADER
    !JSON.parse(response.body)['accessed_at'].nil?
  end

  def exists?
    self.class.exit_if_gem_outdated!
    response = self.class.get "/status/#{key}", headers: USER_AGENT_HEADER
    response.code == 200
  end

  def status
    self.class.exit_if_gem_outdated!
    response = self.class.get "/status/#{key}", headers: USER_AGENT_HEADER
    JSON.parse(response.body)
  end

  def block_until_read
    until read? do
      sleep 1
    end
  end

  private
  attr_accessor :key
end
