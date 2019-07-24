require 'httparty'

class CityWeather
    
	include HTTParty
	 # default_options.update(verify: false) # Turn off SSL
    base_uri "http://api.openweathermap.org/data/2.5/weather"
    default_params appid: '3844d7aa688ce7d38f570a10f818e81a'
    format :json

    def CityWeather.for(city_name)
        response = get('', query: { q: city_name })
        response['main']['temp'] # temp in Kelvin
    end

end
    





