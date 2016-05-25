json.array!(@locations) do |location|
  json.extract! location, :id, :name, :lat, :lng, :description
  json.url location_url(location, format: :json)
end
