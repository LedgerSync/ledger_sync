# frozen_string_literal: true

module Docs
  module Guides
    class Generator < Docs::Generator
      def generate
        clear_dir(
          self.class.destination_folder,
          except: [
            'index.md'
          ]
        )

        ledgers.each_with_index do |ledger, i|
          Docs::Template.new(
            data: {
              ledger: ledger,
              weight: i + 1
            },
            destination_path: destination_path(
              self.class.destination_folder,
              ledger.root_key
            ),
            template_path: template_path(:guides, :ledger)
          ).write

          nl
        end
      end

      def self.destination_folder
        'guides/ledgers'
      end
    end
  end
end
