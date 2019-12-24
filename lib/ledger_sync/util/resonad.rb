# frozen_string_literal: true

#
# Extend the Resonad gem to offer method to raise errors directly
#
class Resonad
  class Success
    def raise_if_error
      self
    end
  end

  class Failure
    def raise_if_error
      raise error
    end
  end
end
