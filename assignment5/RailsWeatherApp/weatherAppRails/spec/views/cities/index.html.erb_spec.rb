require 'rails_helper'

RSpec.describe "cities/index", type: :view do
  before(:each) do
    assign(:cities, [
      City.create!(
        :name => "Name",
        :population => 2,
        :country => "Country",
        :description => "Description"
      ),
      City.create!(
        :name => "Name",
        :population => 2,
        :country => "Country",
        :description => "Description"
      )
    ])
  end

  it "renders a list of cities" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
