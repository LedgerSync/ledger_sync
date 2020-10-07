# frozen_string_literal: true

require 'yaml'

module Docs
  module Reference
    module Ledger
      class Generator < Docs::Generator
        attr_reader :ledger

        def initialize(args = {})
          @ledger = args.fetch(:ledger)

          super
        end

        def client_class
          @client_class ||= ledger.client_class
        end

        def generate
          yellow "Generating Reference for #{key}"
          remove_current_directory
          copy_template_directory
          generate_resource_files
          green "Generated Reference for #{key}"
        end

        def key
          @key ||= ledger.root_key
        end

        def resources
          @resources ||= client_class.resources.to_a.sort
        end

        private

        def copy_template_directory
          cp(docs_path(:_includes, :reference, key), docs_path(:reference))
        end

        def remove_current_directory
          rm(docs_path(:reference, key))
        end

        def generate_resource_files
          FileUtils.mkdir(docs_path(:reference, key, :resources))

          template_path = Generator.template_path(:reference, :resources, :resource)
          count = 1
          resources.each do |resource_key, resource|
            destination_path = Generator.destination_path(
              :reference,
              ledger.root_key,
              :resources,
              resource_key
            )

            Docs::Template.new(
              data: {
                resource: resource,
                client: client_class,
                weight: count
              },
              destination_path: destination_path,
              template_path: template_path
            ).write

            count += 1
          end
        end
      end
    end
  end
end
