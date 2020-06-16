# frozen_string_literal: true

require 'spec_helper'

support :stripe_helpers

RSpec.describe 'stripe/client', type: :feature do
  include StripeHelpers

  let(:client) { stripe_client }
end
