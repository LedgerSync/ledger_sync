# frozen_string_literal: true

module Docs
  class ReferenceResourcesGenerator
    def generate
      Generator.clear_dir(
        self.class.destination_folder,
        except: [
          'index.md'
        ]
      )
      count = 1

      ledgers.each do |ledger|
        client = ledger.client_class
        client.resources.each do |resource_key, resource|
          destination_path = Generator.destination_path(
            self.class.destination_folder,
            "#{ledger.root_key}_#{resource_key}"
          )

          Generator.new(
            data: {
              resource: resource,
              weight: count
            },
            destination_path: destination_path,
            template_path: template_path
          ).generate

          count += 1
        end
        nl
      end
    end

    def ledgers
      @ledgers ||= Generator.ledgers
    end

    def template_path
      Generator.template_path(:reference, :resources, :resource)
    end

    def self.destination_folder
      'guides/tmp'
    end
  end
end
