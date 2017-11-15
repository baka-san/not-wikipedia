class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery :except => :webhooks

  def new
    # get rid of plans model, do it on stripe
    # search docs
    @plan = Stripe::Plan.retrieve(id: 'premium')
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership",
      amount: @plan.amount,
      email: current_user.email
      # plan: @plan
    }
  end

  def create
    # If the user already has an active subscription, don't allow them to subscribe again.
    if current_user.upgraded_account?
      flash[:alert] = "You're already a premium member you silly goose!"
      redirect_to current_user
    else
      begin 
      # Create a subscription in the database and in Stripe
      SubscriptionsService.new(subscriptions_params, current_user).call

      current_user.upgrade_to_premium

      if current_user.save 
        flash[:notice] = "Thanks for all the cash! Feel free to pay us again."
        redirect_to current_user
      else
        flash[:alert] = "We were unable to upgrade your account, but we still took your cash. Just kidding. Please try again or contact support."
        redirect_back(fallback_location: root_path)
      end
      
      # Stripe will send back CardErrors, with friendly messages when something goes wrong.
      # This `rescue block` catches and displays those errors.
      rescue Stripe::CardError => e
        flash[:alert] = e.message
        redirect_to new_subscription_path
      end
    end
  end

  private

    def subscriptions_params
      params.permit(:stripeEmail, :stripeToken)
    end

end
