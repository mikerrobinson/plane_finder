require 'spec_helper'

describe "planes/edit" do
  before(:each) do
    @plane = assign(:plane, stub_model(Plane,
      :image_url => "MyString",
      :base_airport => "MyString",
      :name => "MyString",
      :tail_number => "MyString",
      :notes_text => "MyString",
      :rental_amount => 1,
      :rental_type => "MyString",
      :make => "MyString",
      :model => "MyString",
      :year => "MyString"
    ))
  end

  it "renders the edit plane form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => planes_path(@plane), :method => "post" do
      assert_select "input#plane_image_url", :name => "plane[image_url]"
      assert_select "input#plane_base_airport", :name => "plane[base_airport]"
      assert_select "input#plane_name", :name => "plane[name]"
      assert_select "input#plane_tail_number", :name => "plane[tail_number]"
      assert_select "input#plane_notes_text", :name => "plane[notes_text]"
      assert_select "input#plane_rental_amount", :name => "plane[rental_amount]"
      assert_select "input#plane_rental_type", :name => "plane[rental_type]"
      assert_select "input#plane_make", :name => "plane[make]"
      assert_select "input#plane_model", :name => "plane[model]"
      assert_select "input#plane_year", :name => "plane[year]"
    end
  end
end
