# frozen_string_literal: true

class Site
  @storage = {}

  attr_reader :url, :short_url

  def self.create(url:)
    url = self.prefix(url)
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

  def self.prefix(url)
    if url[0..7] != 'https://' && url[0..6] != 'http://'
      url = "https://" + url
    end

    url
  end
end
