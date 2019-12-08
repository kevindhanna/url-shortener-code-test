require 'site'

describe Site do
  let(:site) { described_class.new(url: 'https://www.farmdrop.com') }
  describe '.url' do
    it 'returns the given url' do
      expect(site.url).to eq 'https://www.farmdrop.com'
    end
  end
end