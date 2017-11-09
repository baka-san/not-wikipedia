require 'stripe'

class SubscriptionsService
  # PLAN = Plan.find_by_name('premium')

  # DEFAULT_CURRENCY = 'usd'

  def initialize(params, user)
    @user = user
    @email = params[:stripeEmail]
    @token = params[:stripeToken]
  end


  def call
    create_subscription(find_customer)
  end

  private

    # Why do we need attr_accessor here? Can't we just use the instance variables?
    # attr_accessor :user, :stripe_email, :stripe_token

    def find_customer
      if @user.stripe_customer_id
        retrieve_customer(@user.stripe_customer_id)
      else
        create_customer
      end
    end

    def retrieve_customer(id)
      Stripe::Customer.retrieve(id) 
    end

    def create_customer
      customer = Stripe::Customer.create(
        email: @email,
        
        source: @token
      )
      @user.update(stripe_customer_id: customer.id)
      customer
    end

    # rename to create subscription
    # rename controller to subscription
    def create_subscription(customer)
      Stripe::Charge.create(
        customer: customer.id,
        amount: 1500,
        description: customer.email,
        currency: 'usd'
      )
  end

end