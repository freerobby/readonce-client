require 'spec_helper'

describe Readonce do
  it 'has a version number' do
    expect(Readonce::VERSION).not_to be nil
  end
  describe '#initialize' do
    it 'creates a readonce file' do
      VCR.use_cassette 'create-file' do
        f = ReadOnce.from_data('dummydata')
        expect(f.read_url).to eql('http://readonce-production.herokuapp.com/3a84c711bcb5ff2afaa23e212f60bb04')
      end
    end
  end

  describe '#exists?' do
    it 'returns true when exists' do
      VCR.use_cassette 'key-exists' do
        f = ReadOnce.from_key('63d2e85319449527d87468a3833365c4')
        expect(f.exists?).to be_truthy
      end
    end
    it 'returns true when exists' do
      VCR.use_cassette 'key-does-not-exist' do
        f = ReadOnce.from_key('a2b7385319449527d87468a3833365c4')
        expect(f.exists?).to be_falsey
      end
    end
  end
end
