json.array!(@location_targets) do |location_target|
  json.extract! location_target, :latitude, :longitude, :address, :description, :title
  json.url location_target_url(location_target, format: :json)
end
