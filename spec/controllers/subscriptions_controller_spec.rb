require 'rails_helper'
require 'stripe_mock'

RSpec.describe SubscriptionsController, type: :controller do

  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }
  
  let(:user) { create(:user) }

  describe "GET new" do

    before do 
      sign_in user
    end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @stripe_btn_data" do
      get :new
      expect(assigns(:stripe_btn_data)).not_to be_nil
    end
  end

  describe "POST create" do
    stripeToken = "tok_12345"

    before do
      sign_in user
    end

    it "returns an http redirect" do
      post :create, params: { stripeToken: stripeToken, stripeEmail: user.email }
      expect(response).to have_http_status(:redirect)
    end
  
    it "creates a new subscription" do
      expect{
        post :create, params: { stripeToken: stripeToken, stripeEmail: user.email }
      }.to change(Subscription, :count).by(1)
    end
  end

end
