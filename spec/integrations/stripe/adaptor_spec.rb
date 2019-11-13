require 'spec_helper'

support :adaptor_helpers
support :stripe_helpers

RSpec.describe 'stripe/adaptor', type: :feature do
  include AdaptorHelpers
  include StripeHelpers

  let(:adaptor) { stripe_adaptor }
end
