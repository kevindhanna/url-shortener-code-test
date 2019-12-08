describe URLShortener do
  describe "POST '/'" do
    it 'returns 201 Created' do
      response = TestParty.post('/', 
        :body => { url: 'http://www.farmdrop.com' }.to_json,
        :headers => { 
          'Content-Type' => 'application/json',
        })
      expect(response.code).to eq 201
    end
    
    it 'returns a JSON containing the created shortened URL' do
      parsed_response = TestParty.post('/', 
        :body => { url: 'http://www.farmdrop.com' }.to_json,
        :headers => { 
          'Content-Type' => 'application/json',
        }).parsed_response
      response = JSON.parse(parsed_response, symbolize_names: true)
      expect(response).to eq({ short_url: "/farmdrop", url: "http://www.farmdrop.com" })
    end
  end
end