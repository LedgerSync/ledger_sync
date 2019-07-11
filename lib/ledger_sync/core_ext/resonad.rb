# frozen_string_literal: true

require 'ledger_sync/util/debug'
require 'simply_serializable'

class Resonad
  include SimplySerializable::Mixin

  class Success < Resonad
    serialize only: %i[value]
  end

  class Failure < Resonad
    serialize only: %i[error]
  end
end
