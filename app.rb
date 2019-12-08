require 'sinatra/base'
require 'site'

class URLShortener < Sinatra::Base

  post '/' do
    parsed_params = JSON.parse(request.body.read, symbolize_names: true)
    site = Site.create(parsed_params)
    status 201
    site.to_json
  end

  get "/:short_url" do
    redirect "https://www.farmdrop.com", 301
  end

end