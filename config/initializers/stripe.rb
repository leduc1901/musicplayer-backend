Rails.configuration.stripe = {
  :publishable_key => "pk_test_51H2rMCGaay8tRlXRoTPTgCSOvcJl7Cs1SG2n7R1Qp3CR68gjlxgBBcNOtKijDeYUJxbTuic3FeRb1HeovuLB500R00mQXvYjZK",
  :secret_key => "sk_test_51H2rMCGaay8tRlXRsXLsxPZSXAc6inzcQBQdXNfGNx7qunE0DzD5o7AyW3IHspubOfcHuy8Z1n6pBA6dlz8QjMBU00VzA06PC1"
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]