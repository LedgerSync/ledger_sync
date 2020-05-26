# frozen_string_literal: true

module Docs
  class Template
    attr_reader :data,
                :destination_path,
                :template_path

    def initialize(args = {})
      @data = args.fetch(:data)
      @destination_path = args.fetch(:destination_path)
      @template_path = args.fetch(:template_path)
    end

    def write
      template = ERB.new(File.read(template_path), trim_mode: '-')
      yellow "Generating template: #{template_path}"
      File.open(destination_path, 'w') { |f| f.write template.result_with_hash(data) }
      green "Wrote to destination: #{destination_path}"
    end
  end
end
