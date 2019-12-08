# frozen_string_literal: true

require 'sinatra/base'
require './lib/site'

class URLShortener < Sinatra::Base
  post '/' do
    parsed_params = JSON.parse(request.body.read, symbolize_names: true)
    status 201
    Site.create(parsed_params).to_json
  end

  get '/:short_url' do
    short_url = "/#{params['short_url']}"
    site = Site.find(short_url: short_url)
    redirect site.url, 301
  end
end
