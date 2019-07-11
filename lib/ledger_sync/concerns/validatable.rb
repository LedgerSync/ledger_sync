module LedgerSync
  module Validatable
    def valid?
      validate.success?
    end

    def validate
      raise NotImplementedError
    end

    def validate_or_fail
      if valid?
        Resonad.Success(self)
      else
        Resonad.Failure
      end
    end
  end
end
