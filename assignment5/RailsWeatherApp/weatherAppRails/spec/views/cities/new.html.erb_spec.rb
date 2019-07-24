require 'rails_helper'

RSpec.describe "cities/new", type: :view do
  before(:each) do
    assign(:city, City.new(
      :name => "MyString",
      :population => 1,
      :country => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new city form" do
    render

    assert_select "form[action=?][method=?]", cities_path, "post" do

      assert_select "input#city_name[name=?]", "city[name]"

      assert_select "input#city_population[name=?]", "city[population]"

      assert_select "input#city_country[name=?]", "city[country]"

      assert_select "input#city_description[name=?]", "city[description]"
    end
  end
end
