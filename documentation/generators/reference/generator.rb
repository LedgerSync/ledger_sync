# frozen_string_literal: true

require_relative 'ledger/generator'

module Docs
  module Reference
    class Generator < Docs::Generator
      def generate
        ledgers.each do |ledger|
          Ledger::Generator.new(ledger: ledger).generate
        end

        generate_indexes
        generate_layouts
        update_nav
      end

      private

      def generate_indexes
        ledgers.each do |client|
          Docs::Template.new(
            data: {
              client: client.client_class
            },
            destination_path: docs_path(:reference, client.root_key, :resources, 'index.md'),
            template_path: template_path(
              :reference,
              :resources,
              :index
            )
          ).write
        end
      end

      def generate_layouts
        ledgers.each do |ledger|
          Docs::Template.new(
            data: {
              client: ledger
            },
            destination_path: docs_path(:_layouts, "reference_#{ledger.root_key}.html"),
            template_path: template_path(
              :_layouts,
              :reference_ledger,
              format: :html
            )
          ).write
        end
      end

      def update_nav
        config_path = docs_path('_config.yml')
        config = YAML.load_file(config_path)
        nav_links = config['header']['nav_links']
        nav_links.map do |nav_link|
          if nav_link['label'] == 'Reference'
            nav_link['subnav_links'] = ledgers.map do |ledger|
              {
                'label' => ledger.name,
                'url' => "reference/#{ledger.root_key}",
                'type' => 'link'
              }
            end
          else
            nav_link
          end
        end

        File.open(config_path, 'w') do |h|
          h.write config.to_yaml
        end
      end
    end
  end
end
