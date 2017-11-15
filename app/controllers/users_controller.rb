class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end


  def downgrade_account
    if current_user.role == "standard"
      flash[:alert] = "You aren't a premium member!"
      redirect_back(fallback_location: root_path)
    else

      current_user.downgrade_to_standard

      if current_user.save 
        flash[:notice] = "You successfully downgraded your account. Goodbye mere standard user"
        redirect_to current_user
      else
        flash[:alert] = "We were unable to downgrade your account. Please try again or contact support."
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def upgrade_account
    if current_user.upgraded_account?
      flash[:alert] = "You're already a premium member you silly goose!"
      redirect_back(fallback_location: root_path)
    else

      current_user.upgrade_to_premium

      if current_user.save 
        flash[:notice] = "You successfully upgraded your account. Thanks for the cash!"
        redirect_to current_user
      else
        flash[:alert] = "We were unable to upgrade your account, but we still took your cash. Just kidding. Please try again or contact support."
        redirect_back(fallback_location: root_path)
      end
    end
  end

end
