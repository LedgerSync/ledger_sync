require 'spec_helper'

support :stripe_helpers

RSpec.describe 'stripe/adaptor', type: :feature do
  include StripeHelpers

  let(:adaptor) { stripe_adaptor }
end
