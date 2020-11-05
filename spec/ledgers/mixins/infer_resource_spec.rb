# frozen_string_literal: true

require 'spec_helper'

module LedgerSync
  module Test
    class Config
      def base_module
          LedgerSync::Test
      end
    end

    class MyResource
      module Operations
        class MyOperation
          include LedgerSync::Ledgers::Mixins::InferResourceClassMixin

          def self.inferred_config
            LedgerSync::Test::Config.new
          end
        end
      end

      class Serializer
        include LedgerSync::Ledgers::Mixins::InferResourceClassMixin

        def self.inferred_config
          LedgerSync::Test::Config.new
        end
      end
    end
  end
end

RSpec.describe LedgerSync::Ledgers::Mixins::InferResourceClassMixin do
  describe 'infering resource from serializer' do
    subject { LedgerSync::Test::MyResource::Serializer }

    it do
      expect(subject.inferred_resource_class).to eq(LedgerSync::Test::MyResource)
    end
  end

  describe 'infering resource from operation' do
    subject { LedgerSync::Test::MyResource::Operations::MyOperation }

    it do
      expect(subject.inferred_resource_class).to eq(LedgerSync::Test::MyResource)
    end
  end
end
