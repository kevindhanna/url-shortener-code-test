describe URLShortener do
  describe "POST '/'" do
    it 'returns 201 Created' do
      response = TestParty.post('/')
      expect(response.code).to eq 201
    end
  end
end