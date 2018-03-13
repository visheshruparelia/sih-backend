require "rails_helper"

RSpec.describe AllfilesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/allfiles").to route_to("allfiles#index")
    end


    it "routes to #show" do
      expect(:get => "/allfiles/1").to route_to("allfiles#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/allfiles").to route_to("allfiles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/allfiles/1").to route_to("allfiles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/allfiles/1").to route_to("allfiles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/allfiles/1").to route_to("allfiles#destroy", :id => "1")
    end

  end
end
