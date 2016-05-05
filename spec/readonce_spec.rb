require 'spec_helper'

describe Readonce do
  it 'has a version number' do
    expect(Readonce::VERSION).not_to be nil
  end
  describe '#initialize' do
    it 'creates a readonce file' do
      VCR.use_cassette 'create-file' do
        f = ReadOnce.from_data('dummydata')
        expect(f.read_url).to eql("#{ReadOnce::BASE_URI}/3a84c711bcb5ff2afaa23e212f60bb04")
      end
    end
  end

  describe '#exists?' do
    it 'returns true when exists' do
      VCR.use_cassette 'key-exists' do
        f = ReadOnce.from_key('93645a5302b2d65b858d8056c781844c')
        expect(f.exists?).to be_truthy
      end
    end
    it 'returns true when exists' do
      VCR.use_cassette 'key-does-not-exist' do
        f = ReadOnce.from_key('foobarfake')
        expect(f.exists?).to be_falsey
      end
    end
  end

  describe '#read?' do
    it 'returns false when unread' do
      VCR.use_cassette 'bag-unread' do
        f = ReadOnce.from_key('dc37debdfa040fe469e9aa248815c81f')
        expect(f.read?).to be_falsey
      end
    end
    it 'returns true when read' do
      VCR.use_cassette 'bag-read' do
        f = ReadOnce.from_key('3df816347dc99e28c4159885f8757dcf')
        expect(f.read?).to be_truthy
      end
    end
  end

  describe '#status' do
    it 'returns ruby hash from status json' do
      VCR.use_cassette 'get-status' do
        f = ReadOnce.from_key('244d26b5cc62b18f29f86065995442e5')
        expect(f.status).to eql({
          'accessed_at' => nil,
          'accessed_by_ip' => nil
        })
      end
    end
  end
end
