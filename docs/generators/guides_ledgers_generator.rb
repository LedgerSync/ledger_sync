# frozen_string_literal: true

module Docs
  class GuidesLedgersGenerator
    def generate
      Generator.clear_dir(
        self.class.destination_folder,
        except: [
          'index.md'
        ]
      )

      ledgers.each_with_index do |ledger, i|
        Generator.new(
          data: {
            ledger: ledger,
            weight: i + 1
          },
          destination_path: Generator.destination_path(
            self.class.destination_folder,
            ledger.root_key
          ),
          template_path: Generator.template_path(:guides, :ledger)
        ).generate

        nl
      end
    end

    def ledgers
      @ledgers ||= Generator.ledgers
    end

    def self.destination_folder
      'guides/ledgers'
    end
  end
end
