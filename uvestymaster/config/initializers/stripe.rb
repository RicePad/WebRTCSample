require "stripe"
Stripe.api_key = "sk_test_LtYHOQWLaju7mdlJYldtUyUI"


Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}


Stripe.api_key = Rails.configuration.stripe[:secret_key]