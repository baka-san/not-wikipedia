class UsersController < ApplicationController

  def index
    @user = User.find_by(email: params[:email])

    respond_to do |format|
      format.js do
        if @user
          render :index, locals: { collaborator: @user }
        else
          render :index, locals: { collaborator: false }
        end
      end
    end

  end

  def show
    @user = User.find(params[:id])
    @subscription = current_user.subscription
  end

end
