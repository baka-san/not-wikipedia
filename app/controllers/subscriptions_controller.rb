class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    # @plan = Stripe::Plan.retrieve(id: 'premium')
    @subscription = Subscription.new
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

  def update
    # should this be update or destroy
    # cancel_at_period_end = true # then it will wait till the end. delete from db in webhook
    # add a column to subscriptions for reoccuring pay true or false

    # If the user already has an active subscription, don't allow them to subscribe again.
    if current_user.standard?
      flash[:alert] = "Hey, you need to upgrade to do that buddy!"
      redirect_to current_user
    else
    # current_user.subscription.downgrade
    end

  end

  private

    def subscriptions_params
      params.permit(:stripeEmail, :stripeToken)
    end

end
