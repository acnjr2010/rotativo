require 'rails_helper'

RSpec.describe "locations/new", type: :view do
  before(:each) do
    assign(:location, Location.new(
      :latitude => 1.5,
      :longitude => 1.5,
      :nome => "MyString",
      :endereco => "MyString",
      :titulo => "MyString"
    ))
  end

  it "renders new location form" do
    render

    assert_select "form[action=?][method=?]", locations_path, "post" do

      assert_select "input#location_latitude[name=?]", "location[latitude]"

      assert_select "input#location_longitude[name=?]", "location[longitude]"

      assert_select "input#location_nome[name=?]", "location[nome]"

      assert_select "input#location_endereco[name=?]", "location[endereco]"

      assert_select "input#location_titulo[name=?]", "location[titulo]"
    end
  end
end
