require 'rails_helper'

RSpec.describe "Allfiles", type: :request do
  describe "GET /allfiles" do
    it "works! (now write some real specs)" do
      get allfiles_path
      expect(response).to have_http_status(200)
    end
  end
end
