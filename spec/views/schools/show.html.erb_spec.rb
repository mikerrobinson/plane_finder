require 'spec_helper'

describe "schools/show" do
  before(:each) do
    @school = assign(:school, stub_model(School,
      :name => "Name",
      :website => "Website",
      :image_url => "Image Url",
      :phone => "Phone",
      :email => "Email",
      :base_airport => "Base Airport"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Website/)
    rendered.should match(/Image Url/)
    rendered.should match(/Phone/)
    rendered.should match(/Email/)
    rendered.should match(/Base Airport/)
  end
end
