require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  let(:user) { create(:user) }
  let(:wiki) { create(:wiki, user_id: user.id) }


  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns Wiki.all to @wiki" do
      get :index
      expect(assigns(:wikis)).to eq([wiki])
    end
  end


end
