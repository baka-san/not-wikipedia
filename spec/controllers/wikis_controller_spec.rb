require 'rails_helper'
# include RandomData
require 'pp'

# See Pundit tests for permissions

RSpec.describe WikisController, type: :controller do

  let(:user) { create(:user) }
  let(:premium_user) { create(:user, role: 'premium') }
  let(:admin) {create(:user, role: 'admin')}
  let(:collaborator) {create(:user, role: 'standard')}

  let(:public_wiki) { create(:wiki, user_id: user.id) }
  let(:private_wiki) { create(:wiki, user_id: premium_user.id, private: true) }
  let(:private_wiki_admin) { create(:wiki, user_id: admin.id, private: true) }

  context "guest" do

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :index
        expect(response).to render_template :index
      end
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

    describe "PUT update" do
      it "returns http redirect" do
        new_title = "New title"
        new_body = "New body"

        put :update, params: { id: wiki.id, wiki: { title: wiki.title, body: wiki.body, user: wiki.user } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, params: { id: wiki.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end  # End context guest

  context "standard user" do

    before(:each) do
      sign_in user
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

    describe "POST create" do
      it "increases the number of wikis by 1" do
        expect{ post :create, params: { wiki: { title: 'Wiki title', body: 'Wiki body', user_id: user.id } } }.to change(Wiki,:count).by(1)
      end

      it "assigns Wiki.last to @wiki" do
        post :create, params: { wiki: { title: 'Wiki title', body: 'Wiki body', user_id: user.id } }
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, params: { wiki: { title: 'Wiki title', body: 'Wiki body', user_id: user.id } }
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: { id: wiki.id }
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, params: { id: wiki.id }
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq wiki.id
        expect(wiki_instance.title).to eq wiki.title
        expect(wiki_instance.body).to eq wiki.body
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = "New title"
        new_body = "New body"

        put :update, params: { id: wiki.id, wiki: { title: 'New title', body: 'New body', user_id: user.id } }

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = "New title"
        new_body = "New body"

        put :update, params: { id: wiki.id, wiki: { title: 'New title', body: 'New body', user_id: user.id } }
        expect(response).to redirect_to wiki
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, params: { id: wiki.id }
        count = Wiki.where({id: wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wikis index" do
        delete :destroy, params: { id: wiki.id }
        expect(response).to redirect_to wikis_path
      end
    end
  end #end standard user context


  context "premium user" do

    before(:each) do
      sign_in premium_user
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

    describe "POST create" do
      it "increases the number of wikis by 1" do
        expect{ post :create, params: { wiki: { title: 'Wiki title', body: 'Wiki body', user_id: user.id } } }.to change(Wiki,:count).by(1)
      end

      it "assigns Wiki.last to @wiki" do
        post :create, params: { wiki: { title: 'Wiki title', body: 'Wiki body', user_id: user.id } }
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, params: { wiki: { title: 'Wiki title', body: 'Wiki body', user_id: user.id } }
        expect(response).to redirect_to Wiki.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: { id: wiki.id }
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, params: { id: wiki.id }
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq wiki.id
        expect(wiki_instance.title).to eq wiki.title
        expect(wiki_instance.body).to eq wiki.body
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = "New title"
        new_body = "New body"

        put :update, params: { id: wiki.id, wiki: { title: 'New title', body: 'New body', user_id: user.id } }

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = "New title"
        new_body = "New body"

        put :update, params: { id: wiki.id, wiki: { title: 'New title', body: 'New body', user_id: user.id } }
        expect(response).to redirect_to wiki
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, params: { id: wiki.id }
        count = Wiki.where({id: wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wikis index" do
        delete :destroy, params: { id: wiki.id }
        expect(response).to redirect_to wikis_path
      end
    end
  end #end member context

end
