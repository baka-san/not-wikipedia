require 'rails_helper'
# include RandomData
require 'pp'

RSpec.describe WikisController, type: :controller do

  let(:user) { create(:user) }
  let(:wiki) { create(:wiki, user_id: user.id) }


  context "guest" do

    describe "GET show" do
      it "returns http success" do
        get :show, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: wiki.id }
        expect(response).to render_template :show
      end

      it "assigns wiki to @wiki" do
        get :show, params: { id: wiki.id }
        expect(assigns(:wiki)).to eq(wiki)
      end
    end

     describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, params: { wiki: { title: wiki.title, body: wiki.body, user: wiki.user } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, params: { id: wiki.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    # describe "PUT update" do
    #   it "returns http redirect" do
    #     new_title = "New title"
    #     new_body = "New body"

    #     put :update, params: { id: wiki.id, wiki: { title: wiki.title, body: wiki.body, user: wiki.user } }
    #     expect(response).to redirect_to(new_user_session_path)
    #   end
    # end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, params: { id: wiki.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end  # End context guest

  context "standard user" do

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      # user2 = User.create!(email: "user1@gmail.com", password: "password", password_confirmation: "password")
      # sign_in user2
      # pp user2
      @user = User.create!(email: "user@gmail.com", password: "password", password_confirmation: "password")
      sign_in @user
      # sign_in :user, user
      # sign_in(:user, user)
      # sign_in(user, scope: :user)
    end

    describe "GET show" do
      it "returns http success" do
        get :show, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: wiki.id }
        expect(response).to render_template :show
      end

      it "assigns wiki to @wiki" do
        get :show, params: { id: wiki.id }
        expect(assigns(:wiki)).to eq(wiki)
      end
    end


    describe "GET new" do
      it "returns http success" do
        # sign_in(:user, user)
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        # sign_in(:user, user)
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        # sign_in(:user, user)
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    # describe "POST create" do
    #   it "increases the number of wikis by 1" do
    #     expect{ post :create, params: { wiki: { title: 'Wiki title', body: 'Wiki body', user_id: user.id } } }.to change(Wiki,:count).by(1)
    #   end

    #   it "assigns Wiki.last to @wiki" do
    #     post :create, params: { wiki: { title: 'Wiki title', body: 'Wiki body', user_id: user.id } }
    #     expect(assigns(:wiki)).to eq Wiki.last
    #   end

    #   it "redirects to the new wiki" do
    #     post :create, params: { wiki: { title: 'Wiki title', body: 'Wiki body', user_id: user.id } }
    #     expect(response).to redirect_to Wiki.last
    #   end
    # end

    # describe "GET edit" do
    #   it "returns http success" do
    #     get :edit, params: { id: wiki.id }
    #     expect(response).to have_http_status(:success)
    #   end

    #   it "renders the #edit view" do
    #     get :edit, params: { id: wiki.id }
    #     expect(response).to render_template :edit
    #   end

    #   it "assigns wiki to be updated to @wiki" do
    #     get :edit, params: { id: wiki.id }
    #     wiki_instance = assigns(:wiki)

    #     expect(wiki_instance.id).to eq wiki.id
    #     expect(wiki_instance.title).to eq wiki.title
    #     expect(wiki_instance.body).to eq wiki.body
    #   end
    # end

    # describe "PUT update" do
    #   it "updates wiki with expected attributes" do
    #     new_title = "New title"
    #     new_body = "New body"

    #     put :update, params: { id: wiki.id, wiki: { title: 'Wiki title', body: 'Wiki body', user_id: user.id } }

    #     updated_wiki = assigns(:wiki)
    #     expect(updated_wiki.id).to eq wiki.id
    #     expect(updated_wiki.title).to eq new_title
    #     expect(updated_wiki.body).to eq new_body
    #   end

    #   it "redirects to the updated wiki" do
    #     new_title = "New title"
    #     new_body = "New body"

    #     put :update, params: { id: wiki.id, wiki: { title: 'Wiki title', body: 'Wiki body', user_id: user.id } }
    #     expect(response).to redirect_to wiki
    #   end
    # end

    # describe "DELETE destroy" do
    #   it "deletes the wiki" do
    #     delete :destroy, params: { id: wiki.id }
    #     count = Post.where({id: wiki.id}).size
    #     expect(count).to eq 0
    #   end

    #   it "redirects to wikis index" do
    #     delete :destroy, params: { id: wiki.id }
    #     expect(response).to redirect_to wikis_path
    #   end
    # end
  end #end member context

end
