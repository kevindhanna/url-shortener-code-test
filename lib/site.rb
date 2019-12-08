# frozen_string_literal: true

class Site
  @storage = {}

  attr_reader :url, :short_url

  def self.create(url:)
    site = Site.new(url: url)
    @storage[site.short_url] = url
    site
  end

  def to_json(*_args)
    Hash[short_url: short_url, url: url].to_json
  end

  def self.find(short_url:)
    Site.new(url: @storage[short_url])
  end

  private

  def initialize(url:)
    @url = url
    @short_url = "/#{url.split('.')[1]}"
  end
end
