# frozen_string_literal: true

require 'spec_helper'

support :type_helpers

RSpec.describe LedgerSync::Type::Boolean do
  include TypeHelpers

  it_behaves_like_a_type_with_valid_types_of(
    :falsey,
    :truthy
  )
end
