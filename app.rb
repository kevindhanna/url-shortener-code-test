# frozen_string_literal: true

require 'sinatra/base'
require './lib/site'

class URLShortener < Sinatra::Base
  post '/' do
    parsed_params = JSON.parse(request.body.read, symbolize_names: true)
    return status 400 if parsed_params[:url].length.zero?

    status 201
    Site.create(parsed_params).to_json
  end

  get '/:short_url' do
    short_url = "/#{params['short_url']}"
    begin
      site = Site.find(short_url: short_url)
    rescue NoMethodError
      return status 400
    end
    redirect site.url, 301
  end
end
