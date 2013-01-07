require 'spec_helper'

describe "planes/show" do
  before(:each) do
    @plane = assign(:plane, stub_model(Plane,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Image Url/)
    rendered.should match(/Base Airport/)
    rendered.should match(/Name/)
    rendered.should match(/Tail Number/)
    rendered.should match(/Notes Text/)
    rendered.should match(/1/)
    rendered.should match(/Rental Type/)
    rendered.should match(/Make/)
    rendered.should match(/Model/)
    rendered.should match(/Year/)
  end
end
