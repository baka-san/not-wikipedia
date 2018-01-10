class CollaborationsController < ApplicationController
  before_action :authenticate_user!

  def create
    respond_to do |format|
      format.js do
        
        @email = collaboration_params[:email].downcase!
        @wiki = Wiki.find(collaboration_params[:wiki_id])
        @collaborator = User.find_by(email: @email)

        # Collaborator exists
        if @collaborator && @collaborator.collaborating_on?(@wiki)
          render :create, locals: { collaborator: @collaborator, wiki: @wiki, state: "exists" }

        # New collaborator
        elsif @collaborator
          @collaboration = Collaboration.new(wiki_id: collaboration_params[:wiki_id], user_id: @collaborator.id)
          authorize @collaboration
          @collaboration.save

          # Make sure wiki is private
          @wiki.private = true
          @wiki.save
          render :create, locals: { collaborator: @collaborator, wiki: @wiki, state: "new" }

        # No such user
        else
          render :create, locals: { collaborator: @collaborator, wiki: @wiki, state: "no_user"}
        end
      end
    end
  end

  def destroy
    respond_to do |format|

      format.js do
        @wiki = Wiki.find(collaboration_destroy_params[:wiki_id])
        @user = User.find(collaboration_destroy_params[:user_id])
        @collaboration = @wiki.collaborations.find_by(user_id: collaboration_destroy_params[:user_id])
        authorize @collaboration
        
        if @collaboration.destroy
          render :destroy, locals: { user: @user}
        else
          flash.now[:alert] = "This collaborator cannot be deleted. Deal with it."
        end
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
