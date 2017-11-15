require 'rails_helper'

RSpec.describe StripeController, type: :controller do

  describe "GET #webhooks" do
    it "returns http success" do
      get :webhooks
      expect(response).to have_http_status(:success)
    end
  end

end
