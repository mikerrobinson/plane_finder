require 'spec_helper'

describe "schools/index" do
  before(:each) do
    assign(:schools, [
      stub_model(School,
        :name => "Name",
        :website => "Website",
        :image_url => "Image Url",
        :phone => "Phone",
        :email => "Email",
        :base_airport => "Base Airport"
      ),
      stub_model(School,
        :name => "Name",
        :website => "Website",
        :image_url => "Image Url",
        :phone => "Phone",
        :email => "Email",
        :base_airport => "Base Airport"
      )
    ])
  end

  it "renders a list of schools" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Website".to_s, :count => 2
    assert_select "tr>td", :text => "Image Url".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Base Airport".to_s, :count => 2
  end
end
