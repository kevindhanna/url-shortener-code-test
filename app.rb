require 'sinatra/base'

class URLShortener < Sinatra::Base

  post '/' do
    status 201
    { short_url: "/farmdrop", url: "http://www.farmdrop.com" }.to_json
  end

end