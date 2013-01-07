require "spec_helper"

describe PlanesController do
  describe "routing" do

    it "routes to #index" do
      get("/planes").should route_to("planes#index")
    end

    it "routes to #new" do
      get("/planes/new").should route_to("planes#new")
    end

    it "routes to #show" do
      get("/planes/1").should route_to("planes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/planes/1/edit").should route_to("planes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/planes").should route_to("planes#create")
    end

    it "routes to #update" do
      put("/planes/1").should route_to("planes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/planes/1").should route_to("planes#destroy", :id => "1")
    end

  end
end
