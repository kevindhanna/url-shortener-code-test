describe URLShortener do
  before :all do 
    @server_thread = Thread.new do
      Rack::Handler::pick(['puma']).run URLShortener.new, Port: 9292
    end
    begin
      response = TestParty.get('/')
    rescue StandardError => e
      p 'waiting for server to start...'
      sleep 1
    end until response
  end

  describe "POST '/'" do
    it 'returns 201 Created' do
      response = TestParty.post('/', 
        :body => { url: 'https://www.farmdrop.com' }.to_json,
        :headers => { 
          'Content-Type' => 'application/json',
        })
      expect(response.code).to eq 201
    end
    
    it 'returns a JSON containing the created shortened URL' do
      parsed_response = TestParty.post('/', 
        :body => { url: 'https://www.farmdrop.com' }.to_json,
        :headers => { 
          'Content-Type' => 'application/json',
        }).parsed_response
      response = JSON.parse(parsed_response, symbolize_names: true)
      expect(response).to eq({ short_url: "/farmdrop", url: "https://www.farmdrop.com" })
    end

    it 'returns a JSON containing the created shortened URL' do
      parsed_response = TestParty.post('/', 
        :body => { url: 'https://www.google.com' }.to_json,
        :headers => { 
          'Content-Type' => 'application/json',
        }).parsed_response
      response = JSON.parse(parsed_response, symbolize_names: true)
      expect(response).to eq({ short_url: "/google", url: "https://www.google.com" })
    end
  end

  describe 'GET "/url"' do
    before :all do
      TestParty.post('/', 
        :body => { url: 'https://www.farmdrop.com' }.to_json,
        :headers => { 
          'Content-Type' => 'application/json',
        })
    end
    it 'returns 301 Permanently Moved' do
      response = TestParty.get('/farmdrop', follow_redirects: false)
      expect(response.code).to eq 301
    end

    it 'redirects to the full URL' do
      response = TestParty.get('/farmdrop', follow_redirects: false)
      redirect_url = response.headers['location']
      expect(redirect_url).to eq 'https://www.farmdrop.com'
    end
  end
end