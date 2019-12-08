class Site
  attr_reader :url, :short_url

  def initialize(url:)
    @url = url
    @short_url = "/#{url.split('.')[1]}"
  end

  def to_json
    Hash[short_url: short_url, url: url].to_json
  end

end