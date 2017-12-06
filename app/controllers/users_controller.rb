class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    subscription = current_user.subscription
  end

end
