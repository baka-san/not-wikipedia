class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership",
      amount: 1500,
      email: current_user.email
    }
  end

  def create
    ChargesService.new(charges_params, current_user).call

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to root_url
  
    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end


  private

    def charges_params
      params.permit(:stripeEmail, :stripeToken, :plan)
    end

end
