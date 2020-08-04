# frozen_string_literal: true

require 'spec_helper'

support :type_helpers

RSpec.describe LedgerSync::Type::Date do
  include TypeHelpers

  it_behaves_like_a_type_with_valid_types_of(
    :date,
    [:date_string, Date.new(2020, 2, 2).to_s, Date.new(2020, 2, 2)]
  )
end
