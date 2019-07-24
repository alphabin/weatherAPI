require 'rails_helper'

RSpec.describe "Cities", type: :request do

  before(:each) do 
    # create database record for Tokyo
    City.create(name: 'Tokyo', population: 38001000, country: 'Japan', description: 'Meiji Shinto, museums' )
    # create mock for CityWeather.for class method.  The mock will returns  300 degree Kelvin as current temp
    allow(CityWeather).to receive(:for) { 300 } 
  end 
  
  describe "GET /cities" do
  
    it 'get city information for Tokyo should return JSON array of length 1 of city objects' do
      headers = { "ACCEPT" => "application/json"}    # Rails 4 
      get '/cities?name=Tokyo', headers: headers
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body) 
      expect(json_response.length).to eq 1
      city = json_response[0]
      expect(city.keys).to contain_exactly( 
        'id',
        'name',
        'population',
        'temp',
        'country',
        'description',
        'created_at',
        'updated_at',
        'url')
      expect(city['population']).to eq 38001000
      expect(city['name']).to eq 'Tokyo'
      expect(city['country']).to eq 'Japan'
      expect(city['temp']).to eq 80.33
    end 
  
 
    it 'get city information for non existent city should return JSON array of length 0' do 
      headers = { "ACCEPT" => "application/json"}    # Rails 4 
      get '/cities?name=nocity', headers: headers
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body) 
      expect(json_response.length).to eq 0
    end 
  end
  
  describe "POST /cities" do
    it 'post of new city should return city information' do
      headers = { "CONTENT_TYPE" => "application/json" ,
                   "ACCEPT" => "application/json"}    # Rails 4
      city_new = {name: 'London', population: 7285000, country: 'United Kingdom', description: 'Buckingham Palace, Big Ben'} 
      post '/cities',  params: city_new.to_json, headers: headers
      expect(response).to have_http_status(201)
      city = JSON.parse(response.body) 
       expect(city.keys).to contain_exactly( 
         'id',
        'name',
        'population',
        'temp',
        'country',
        'description',
        'created_at',
        'updated_at',
        'url')
      expect(city['population']).to eq 7285000
      expect(city['name']).to eq 'London'
      expect(city['country']).to eq 'United Kingdom'
      
      # check that database has been updated
      citydb = City.find(city['id'])
      expect(citydb.population).to eq 7285000
      expect(citydb.name).to eq 'London'
      expect(citydb.country).to eq 'United Kingdom'
    end 
  end
  
  describe "PUT /cities/:id" do
    it 'update of a city should return updated city information' do
      headers = { "CONTENT_TYPE" => "application/json" ,
                   "ACCEPT" => "application/json"}    # Rails 4
      city_new = {name: 'London', population: 7285000, country: 'United Kingdom', description: 'Buckingham Palace, Big Ben'} 
      #Manually create it
      city = City.new (city_new)
      city.save
      # update the city population and issue http put
      city['population']= "7290000"
      put "/cities/#{city['id']}", params: city.to_json, headers: headers 
      expect(response).to have_http_status(200)
      city_returned = JSON.parse(response.body)
      expect(city_returned['population']).to eq city['population']
      
      # verify db change
      citydb = City.find(city['id'])
      expect(citydb.population).to eq city['population']
    end 
  end
  
  describe "DELETE /cities" do
    it 'get city id for Tokyo and delete it' do
      headers = { "CONTENT_TYPE" => "application/json" ,
                  "ACCEPT" => "application/json"}    # Rails 4
      get '/cities.json?name=Tokyo', headers: headers
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body) 
      expect(json_response.length).to eq 1
      city = json_response[0]
      delete  "/cities/#{city['id']}" , headers: headers
      expect(response).to have_http_status(204)
      # verify db record has been deleted.
      get '/cities.json?name=Tokyo', headers: headers
      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body) 
      expect(json_response.length).to eq 0
    end 
  end 
  
end 
