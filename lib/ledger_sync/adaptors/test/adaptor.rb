module LedgerSync
  module Adaptors
    module Test
      class Adaptor < LedgerSync::Adaptors::Adaptor
        def initialize(*_config); end

        def find(resource:, id:)
          { 'id' => id }
        end

        def post(resource:, payload:)
          payload
        end

        def query(resource:, query:)
          resource_klass = LedgerSync.resources[resource.to_sym]

          Array.new(2) do |i|
            ret = {
              'id' => SecureRandom.uuid,
            }

            ret['name'] = "Test #{resource} #{i}" if resource_klass.instance_methods.include?(:name=)
            ret
          end
        end

        def refresh!
          self
        end

        def url_for(resource:)
          case resource
          when LedgerSync::Customer
            "http://example.com/customer/#{resource.ledger_id}"
          else
            raise NotImplementedError
          end
        end

        def self.ledger_attributes_to_save
          []
        end
      end
    end
  end
end
