# frozen_string_literal: true

require 'site'

describe Site do
  let(:site) { described_class.create(url: 'https://www.farmdrop.com') }

  describe '#create' do
    it 'creates an instance of the class' do
      site = Site.create(url: 'https://www.google.com')
      expect(site.short_url).to eq '/google'
    end

    it 'accepts urls without https://' do
      site = Site.create(url: 'www.google.com')
      expect(site.url).to eq 'https://www.google.com'
    end
  end

  describe '.url' do
    it 'returns the given url' do
      expect(site.url).to eq 'https://www.farmdrop.com'
    end
  end

  describe '.short_url' do
    it 'returns a shortened version of the url' do
      expect(site.short_url).to eq '/farmdrop'
    end

    it 'returns a shortened version of the url' do
      site = Site.create(url: 'https://www.google.com')
      expect(site.short_url).to eq '/google'
    end
  end

  describe '.to_json' do
    it 'returns the url and short_url in a json object' do
      expect(site.to_json).to eq({
        short_url: '/farmdrop',
        url: 'https://www.farmdrop.com'
      }.to_json)
    end
  end

  describe '#find' do
    it 'returns the previously create site' do
      site = Site.find(short_url: '/farmdrop')
      expect(site.url).to eq 'https://www.farmdrop.com'
    end

    it 'returns the previously create site' do
      Site.create(url: 'https://www.google.com')
      expect(Site.find(short_url: '/google').url).to eq 'https://www.google.com'
    end
  end
end
