class BackgroundPhoto
  attr_reader :id,
              :photo_url

  def initialize(photo_url)
    @id = nil
    @photo_url = photo_url
  end

  def self.get_city_photo(city_param)
    url = PhotoService.get_photo(city_param)
    BackgroundPhoto.new(url)
  end

  def cache_key
    self.photo_url
  end
end
