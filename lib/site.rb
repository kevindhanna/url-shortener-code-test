class Site
  attr_reader :url

  def initialize(url:)
    @url = url
  end

  def short_url
    "/#{url.split('.')[1]}"
  end

end