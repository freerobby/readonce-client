require 'spec_helper'

describe Readonce do
  it 'has a version number' do
    expect(Readonce::VERSION).not_to be nil
  end
  describe '#initialize' do
    it 'creates a readonce file' do
      VCR.use_cassette 'create-file' do
        f = ReadOnce.new('dummydata')
        expect(f.read_url).to eql('http://readonce-production.herokuapp.com/3a84c711bcb5ff2afaa23e212f60bb04')
      end
    end
  end
end
