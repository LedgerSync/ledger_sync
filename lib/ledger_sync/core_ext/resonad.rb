# frozen_string_literal: true

require 'simply_serializable'

class Resonad
  include SimplySerializable::Mixin

  class Success < Resonad
    simply_serialize only: %i[value]
  end

  class Failure < Resonad
    simply_serialize only: %i[error]
  end
end
