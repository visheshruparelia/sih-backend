require 'rails_helper'

RSpec.describe "FileUsers", type: :request do
  describe "GET /file_users" do
    it "works! (now write some real specs)" do
      get file_users_path
      expect(response).to have_http_status(200)
    end
  end
end
