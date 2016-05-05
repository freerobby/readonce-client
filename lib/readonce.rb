require 'readonce/version'

require 'httparty'

class ReadOnce
  BASE_URI = 'https://readonce-production.herokuapp.com'

  def self.from_key(key)
    r = ReadOnce.new
    r.instance_variable_set(:@key, key)
    r
  end

  def self.from_data(data)
    response = HTTParty.post "#{BASE_URI}/create", body: data, headers: {'Content-type' => 'text/plain'}
    r = ReadOnce.new
    r.instance_variable_set(:@key, response.body)
    r
  end

  def read_url
    "#{BASE_URI}/#{key}"
  end

  def read?
    response = HTTParty.get "#{BASE_URI}/status/#{key}"
    !JSON.parse(response.body)['accessed_at'].nil?
  end

  def exists?
    response = HTTParty.get "#{BASE_URI}/status/#{key}"
    response.code == 200
  end

  def status
    response = HTTParty.get "#{BASE_URI}/status/#{key}"
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
