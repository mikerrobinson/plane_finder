require 'spec_helper'

describe "planes/index" do
  before(:each) do
    assign(:planes, [
      stub_model(Plane,
        :image_url => "Image Url",
        :base_airport => "Base Airport",
        :name => "Name",
        :tail_number => "Tail Number",
        :notes_text => "Notes Text",
        :rental_amount => 1,
        :rental_type => "Rental Type",
        :make => "Make",
        :model => "Model",
        :year => "Year"
      ),
      stub_model(Plane,
        :image_url => "Image Url",
        :base_airport => "Base Airport",
        :name => "Name",
        :tail_number => "Tail Number",
        :notes_text => "Notes Text",
        :rental_amount => 1,
        :rental_type => "Rental Type",
        :make => "Make",
        :model => "Model",
        :year => "Year"
      )
    ])
  end

  it "renders a list of planes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Image Url".to_s, :count => 2
    assert_select "tr>td", :text => "Base Airport".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Tail Number".to_s, :count => 2
    assert_select "tr>td", :text => "Notes Text".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Rental Type".to_s, :count => 2
    assert_select "tr>td", :text => "Make".to_s, :count => 2
    assert_select "tr>td", :text => "Model".to_s, :count => 2
    assert_select "tr>td", :text => "Year".to_s, :count => 2
  end
end
