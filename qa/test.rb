# frozen_string_literal: true

module QA
  class Test
    attr_reader :config,
                :test_run_id

    def initialize(config:)
      @config = config
      @test_run_id = (0...8).map { rand(65..90).chr }.join
      puts "Initialized Test: #{test_run_id}"
    end

    def cleanup
    end

    def perform(op)
      if op.valid?
        result = op.perform
        if op.failure?
          byebug
          raise op.error
        end
        return result
      end

      byebug
      raise op.validate
    end

    def new_customer(**args)
      LedgerSync::Customer.new(
        {
          email: "#{test_run_id}@example.com",
          name: "Test Customer #{test_run_id}",
          phone_number: '1234567890'
        }.merge(args)
      )
    end

    def new_vendor(**args)
      LedgerSync::Vendor.new(
        {
          email: "test-#{test_run_id}-vendor@example.com",
          first_name: "TestFirst#{test_run_id}",
          last_name: "TestLast#{test_run_id}",
          display_name: "Test #{test_run_id} Display Name"
        }.merge(args)
      )
    end

    def run
      raise NotImplementedError
    end
  end
end
