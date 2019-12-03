# frozen_string_literal: true

module OperationHelpers
  def expect_valid(operation:)
    pdb operation.errors unless operation.valid?

    expect(operation).to be_valid
  end
end
