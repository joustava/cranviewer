require 'rails_helper'

RSpec.describe PackagesController, type: :controller do

  before {
    @package = Package.create!(name: "asdf", version: "1")
  }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {:id => @package.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #description" do
    it "returns http success" do
      get :description, params: {:id => @package.id }
      expect(response).to have_http_status(:success)
    end
  end

end
