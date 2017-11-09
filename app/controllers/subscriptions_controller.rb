class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def new
    # get rid of plans model, do it on stripe
    # search docs
    @plan = Stripe::Plan.retrieve(id: 'premium')
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership",
      amount: @plan.amount,
      email: current_user.email,
      # plan: @plan
    }
  end

  def create
    SubscriptionsService.new(subscriptions_params, current_user).call

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to root_url
  
    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_subscription_path
  end


  private

    def subscriptions_params
      params.permit(:stripeEmail, :stripeToken)
    end

end
