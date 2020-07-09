class ChargesController < ApplicationController
  def create
    Stripe.api_key = "sk_test_51H2rMCGaay8tRlXRsXLsxPZSXAc6inzcQBQdXNfGNx7qunE0DzD5o7AyW3IHspubOfcHuy8Z1n6pBA6dlz8QjMBU00VzA06PC1"
    charge = Stripe::Charge.create(
      :amount => 100,
      :description => "Gold Member",
      :currency => "USD",
      :source => params[:token]
    )
    @user = User.find(params[:id])
    @user.update_attribute(:verify , "verified")

    render json: {status: 'complete'}
  rescue Stripe::CardError => e
    render json: {error: e.message}
  end
end
