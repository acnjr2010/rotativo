require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        :latitude => 1.5,
        :longitude => 1.5,
        :nome => "Nome",
        :endereco => "Endereco",
        :titulo => "Titulo"
      ),
      Location.create!(
        :latitude => 1.5,
        :longitude => 1.5,
        :nome => "Nome",
        :endereco => "Endereco",
        :titulo => "Titulo"
      )
    ])
  end

  it "renders a list of locations" do
    render
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => "Endereco".to_s, :count => 2
    assert_select "tr>td", :text => "Titulo".to_s, :count => 2
  end
end
