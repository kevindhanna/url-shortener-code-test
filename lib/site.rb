class Site
  attr_reader :url

  def initialize(url:)
    @url = url
  end

  def short_url
    '/farmdrop'
  end

end