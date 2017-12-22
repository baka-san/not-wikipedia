class CollaborationsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def create
    respond_to do |format|

      format.js do
        @wiki = Wiki.find(collaboration_params[:wiki_id])
        @user = User.find_by(email: collaboration_params[:email])

        if @user && !@user.collaborating_on?(@wiki)
          @collaboration = Collaboration.create(wiki_id: collaboration_params[:wiki_id], user_id: @user.id)
        end

        render :create, locals: { user: @user, wiki: @wiki }

        # Use rescue_from?
        # NoMethodError on a nil class i.e. no user
        # SQLite3::ConstraintException i.e. user already exists
      end
    end
  end

  def destroy
    
  end

  private

    def collaboration_params
      params.permit(:email, :wiki_id)
    end
  
end
