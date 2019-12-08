require 'sinatra/base'
require 'site'

class URLShortener < Sinatra::Base

  post '/' do
    parsed_params = JSON.parse(request.body.read, symbolize_names: true)
    site = Site.new(parsed_params)
    status 201
    site.to_json
  end

  get "/:short_url" do
    status 301
  end

end