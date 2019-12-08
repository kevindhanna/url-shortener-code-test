require 'site'

describe Site do
  let(:site) { described_class.new(url: 'https://www.farmdrop.com') }
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
      site = Site.new(url: 'https://www.google.com')
      expect(site.short_url).to eq '/google'
    end
  end

  describe '.to_json' do
    it 'returns the url and short_url in a json object' do
      expect(site.to_json).to eq({ short_url: "/farmdrop", url: "https://www.farmdrop.com" }.to_json)
    end
  end

  describe '#find' do
    it 'returns the previously created site' do
      site = Site.find(short_url: '/farmdrop')
      expect(site.url).to eq 'https://www.farmdrop.com'
    end
  end
end