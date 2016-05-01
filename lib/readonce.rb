require 'readonce/version'

require 'httparty'

class ReadOnce
  BASE_URI = 'http://readonce-production.herokuapp.com'
  def initialize(data)
    puts data
    response = HTTParty.post "#{BASE_URI}/create", body: data
    self.key = response.body
  end

  def read_url
    "#{BASE_URI}/#{key}"
  end

  private
  attr_accessor :key
end
