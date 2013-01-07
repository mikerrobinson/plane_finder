require 'spec_helper'

describe "schools/edit" do
  before(:each) do
    @school = assign(:school, stub_model(School,
      :name => "MyString",
      :website => "MyString",
      :image_url => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :base_airport => "MyString"
    ))
  end

  it "renders the edit school form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => schools_path(@school), :method => "post" do
      assert_select "input#school_name", :name => "school[name]"
      assert_select "input#school_website", :name => "school[website]"
      assert_select "input#school_image_url", :name => "school[image_url]"
      assert_select "input#school_phone", :name => "school[phone]"
      assert_select "input#school_email", :name => "school[email]"
      assert_select "input#school_base_airport", :name => "school[base_airport]"
    end
  end
end
