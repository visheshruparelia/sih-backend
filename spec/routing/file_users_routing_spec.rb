require "rails_helper"

RSpec.describe FileUsersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/file_users").to route_to("file_users#index")
    end


    it "routes to #show" do
      expect(:get => "/file_users/1").to route_to("file_users#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/file_users").to route_to("file_users#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/file_users/1").to route_to("file_users#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/file_users/1").to route_to("file_users#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/file_users/1").to route_to("file_users#destroy", :id => "1")
    end

  end
end
