class UsersController < ApplicationController

  def index
    @user = User.find_by(email: params[:email])

    respond_to do |format|
      
      format.html
      format.js { render :index, locals: { user: @user } }
    end

  end

  def show
    @user = User.find(params[:id])
    @subscription = current_user.subscription
  end

end
