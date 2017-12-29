class CollaborationsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def create
    respond_to do |format|

      format.js do
        @wiki = Wiki.find(collaboration_params[:wiki_id])
        @user = User.find_by(email: collaboration_params[:email])

        if @user && @user.collaborating_on?(@wiki)
          render :create, locals: { user: @user, wiki: @wiki, state: "exists" }
        elsif @user
          @collaboration = Collaboration.create(wiki_id: collaboration_params[:wiki_id], user_id: @user.id)
          render :create, locals: { user: @user, wiki: @wiki, state: "new" }
        else
          render :create, locals: { user: @user, wiki: @wiki, state: "no_user"}
        end
      end
    end
  end

  def destroy
    # @wiki = Wiki.find(params[:id])
    # authorize @wiki

    # if @wiki.destroy
    #   flash[:notice] = "\"#{@wiki.title}\" is dead. Good job, you killed it."
    #   redirect_to action: :index
    # else
    #   flash.now[:alert] = "There was an error killing the wiki. The police will arrive shortly."
    #   render :show
    # end

    respond_to do |format|


      format.html do

        # byebug

        # @wiki = Wiki.find(collaboration_destroy_params[:wiki_id])
        # @user = User.find(collaboration_destroy_params[:user_id])
        # @collaboration = @wiki.collaborations.where(user_id: @user.id)

        # if @collaboration[0].destroy
        #   flash[:notice] = "The collaborator is dead. Good job, you killed it."
        #   # redirect_to action: :index
        # else
        #   flash.now[:alert] = "There was an error killing the collaboration. The police will arrive shortly."
        #   # render :show
        # end
      end

      format.js do
        # @wiki = Wiki.find(collaboration_params[:wiki_id])
        # @user = User.find_by(email: collaboration_params[:email])

        # render :create, locals: { user: @user, wiki: @wiki }

        # if @user && !@user.collaborating_on?(@wiki)
        #   @collaboration = Collaboration.create(wiki_id: collaboration_params[:wiki_id], user_id: @user.id)
        # end

        # Use rescue_from?
        # NoMethodError on a nil class i.e. no user
        # SQLite3::ConstraintException i.e. user already exists
      end
    end
    
  end

  private

    def collaboration_params
      params.permit(:email, :wiki_id)
    end

    def collaboration_destroy_params
      params.permit(:wiki_id, :user_id)
    end
  
end
