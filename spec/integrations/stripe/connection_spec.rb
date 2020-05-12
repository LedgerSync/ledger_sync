require 'spec_helper'

support :stripe_helpers

RSpec.describe 'stripe/connection', type: :feature do
  include StripeHelpers

  let(:connection) { stripe_connection }
end
