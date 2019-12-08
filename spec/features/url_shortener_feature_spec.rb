# frozen_string_literal: true

describe URLShortener do
  before :all do
    @server_thread = Thread.new do
      Rack::Handler.pick(['puma']).run URLShortener.new, Port: 9292
    end
    begin
      response = TestParty.get('/')
    rescue StandardError
      p 'waiting for server to start...'
      sleep 1
    end until response
  end

  describe "POST '/'" do
    it 'returns 201 Created' do
      response = TestParty.post(
        '/',
        body: {
          url: 'https://www.farmdrop.com'
        }.to_json,
        headers: {
          'Content-Type' => 'application/json'
        }
      )
      expect(response.code).to eq 201
    end

    it 'returns a JSON containing the created shortened URL' do
      parsed_response = TestParty.post(
        '/',
        body: {
          url: 'https://www.farmdrop.com'
        }.to_json,
        headers: {
          'Content-Type' => 'application/json'
        }
      ).parsed_response
      response = JSON.parse(parsed_response, symbolize_names: true)
      expect(response).to eq(
        short_url: '/farmdrop',
        url: 'https://www.farmdrop.com'
      )
    end

    it 'returns a JSON containing the created shortened URL' do
      parsed_response = TestParty.post(
        '/',
        body: {
          url: 'https://www.google.com'
        }.to_json,
        headers: {
          'Content-Type' => 'application/json'
        }
      ).parsed_response
      response = JSON.parse(parsed_response, symbolize_names: true)
      expect(response).to eq(
        short_url: '/google',
        url: 'https://www.google.com'
      )
    end

    it 'accepts urls without https://' do
      parsed_response = TestParty.post(
        '/',
        body: {
          url: 'www.farmdrop.com'
        }.to_json,
        headers: {
          'Content-Type' => 'application/json'
        }
      ).parsed_response
      response = JSON.parse(parsed_response, symbolize_names: true)
      expect(response).to eq(
        short_url: '/farmdrop',
        url: 'https://www.farmdrop.com'
      )
    end

    it 'returns invalid request for empty urls' do
      response = TestParty.post(
        '/',
        body: {
          url: ''
        }.to_json,
        headers: {
          'Content-Type' => 'application/json'
        }
      )
      expect(response.code).to eq 400
    end
  end

  describe 'GET "/url"' do
    before :all do
      TestParty.post(
        '/',
        body: { url: 'https://www.farmdrop.com' }.to_json,
        headers: {
          'Content-Type' => 'application/json'
        }
      )
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

    it 'redirects to the full URL' do
      TestParty.post(
        '/',
        body: { url: 'https://www.google.com' }.to_json,
        headers: {
          'Content-Type' => 'application/json'
        }
      )
      response = TestParty.get('/google', follow_redirects: false)
      redirect_url = response.headers['location']
      expect(redirect_url).to eq 'https://www.google.com'
    end

    it 'returns invalid request for urls that havent been shortened' do
      response = TestParty.get('/test', follow_redirects: false)
      expect(response.code).to eq 400
    end
  end
end
