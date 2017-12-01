class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    subscription = current_user.subscription
    @date = subscription.autopay ? display_date(subscription.current_period_end) : "--/--/----"
  end

end
