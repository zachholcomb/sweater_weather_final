class BackgroundImageSerializer
  include FastJsonapi::ObjectSerializer
  cache_options enabled: true, cache_length: 12.hours
  attributes :photo_url
end
