class City < ApplicationRecord
    def temp(units=:farhenheit, precision=2)
        tempK = CityWeather.for(self.name)
 
        if units == :farhenheit
            temp = (tempK.to_f - 273.15)*9.0/5.0 + 32.0
        else
        # return temp in celcius
            temp = tempK - 273.15
        end
        temp.round(precision)
    end
end