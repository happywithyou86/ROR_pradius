json.array!(@advertisements) do |advertisement|
  json.extract! advertisement, :id, :url, :country_id, :position
  json.url advertisement_url(advertisement, format: :json)
end
