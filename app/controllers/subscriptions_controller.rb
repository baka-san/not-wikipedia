class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.upgraded_account?
      flash[:alert] = "You're already a premium member you silly goose!"
      redirect_to current_user
    else
      @subscription = Subscription.new
    end
  end

  def create
    # If the user already has an active subscription, don't allow them to subscribe again.
    if current_user.upgraded_account?
      flash[:alert] = "You're already a premium member you silly goose!"
      redirect_to current_user
    else
      begin 
      # Create a subscription in the database and in Stripe
      SubscriptionsService.new(subscriptions_params, current_user).call_create

      current_user.upgrade_to_premium

      if current_user.save 
        flash[:notice] = "Thanks for all the cash! Feel free to pay us again."
        redirect_to current_user
      else
        flash[:alert] = "We were unable to upgrade your account, but we still took your cash. Just kidding. Please try again or contact support."
        redirect_back(fallback_location: root_path)
      end
      
      # Stripe will send back CardErrors, displayed in this rescue block.
      rescue Stripe::CardError => e
        flash[:alert] = e.message
        redirect_to new_subscription_path
      end
    end
  end

  def turn_on_autopay
    if current_user.role != "premium"
      flash[:alert] = "You aren't a premium member!"
      redirect_back(fallback_location: root_path)
    else
      subscription = current_user.subscription
      subscription.turn_on_autopay

      flash.now[:notice] = "You're successfully set up to give us more money. Thanks for the cash!\
                        Your next payment will automatically occur on #{display_date(subscription.current_period_end)}."
      redirect_to current_user
    end
  end

  def turn_off_autopay
    if current_user.role != "premium"
      flash[:alert] = "You aren't a premium member!"
      redirect_back(fallback_location: root_path)
    else
      subscription = current_user.subscription
      subscription.turn_off_autopay

      flash.now[:notice] = "Your account will be downgraded on #{display_date(subscription.current_period_end)}. Goodbye mere standard user."
      redirect_to current_user
    end
  end

  private

    def subscriptions_params
      params.permit(:stripeEmail, :stripeToken)
    end

end
