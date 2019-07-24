json.extract! city, :id, :name, :population,:temp, :country, :description, :created_at, :updated_at
json.url city_url(city, format: :json)
