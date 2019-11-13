# frozen_string_literal: true

module QA
  class Test
    attr_reader :config,
                :test_run_id

    def initialize(config:, test_run_id:)
      @config = config
      @test_run_id = test_run_id
    end

    def perform(op)
      if op.valid?
        result = op.perform
        byebug if op.failure?
        return result
      end

      raise op.validate
    end

    def new_customer(**args)
      LedgerSync::Customer.new(
        {
          email: "#{TEST_RUN_ID}@example.com",
          name: "Test Customer #{TEST_RUN_ID}",
          phone_number: '1234567890'
        }.merge(args)
      )
    end

    def run
      raise NotImplementedError
    end
  end
end
