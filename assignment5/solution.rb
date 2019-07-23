require_relative 'city_weather'


puts 'Enter City'
city = gets.chomp!
response = CityWeather.for(city)

puts 'response received'
puts response

# check for good return code
if response['cod'] == 200 
  puts 
  puts "the current temp for #{city} is"
  
  # convert Kelvin degrees to fahrenheit 
  puts "#{((response['main']['temp'] - 273.15)*9.0/5.0 + 32.0).round(2)} degrees Farenheit"

  # convert time given in 'dt' to local time at location
  puts "taken at #{Time.at(response['dt']).utc.getlocal(response['timezone'])}"
end 

