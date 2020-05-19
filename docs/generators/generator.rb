# frozen_string_literal: true

module Docs
  class Generator
    attr_reader :data,
                :destination_path,
                :template_path

    def initialize(args = {})
      @data = args.fetch(:data)
      @destination_path = args.fetch(:destination_path)
      @template_path = args.fetch(:template_path)
    end

    def generate
      template = ERB.new(File.read(template_path), nil, '-')
      yellow "Generating template: #{template_path}"
      File.open(destination_path, 'w') { |f| f.write template.result_with_hash(data) }
      green "Wrote to destination: #{destination_path}"
    end

    def self.clear_dir(path, except: [])
      dir_path = docs_path(path)
      yellow "Clearing: #{dir_path}"
      Dir.foreach(dir_path) do |f|
        next if except.include?(f)

        fn = File.join(dir_path, f)
        next if f == '.'
        next if f == '..'

        yellow "Removing: #{fn}"
        FileUtils.rm_rf(fn, secure: true)
        green "Removed: #{fn}"
        nl
      end
      green "Cleared: #{dir_path}"
      nl
    end

    def self.destination_path(*args, **keywords)
      docs_path(*args, **{ format: :md }.merge(keywords))
    end

    def self.docs_path(*path, format: nil)
      path = path.map(&:to_s)

      File.join(
        ENV.fetch('DOCS_ROOT_PATH'),
        *path[0..-2],
        [path.last, format].flatten.compact.join('.')
      )
    end

    def self.ledgers
      LedgerSync.ledgers
                .to_a
                .map(&:last)
                .uniq
                .to_a
                .sort_by(&:root_key)
    end

    def self.template_path(*path, format: :md)
      path = path.map(&:to_s)

      File.join(
        ENV.fetch('DOCS_ROOT_PATH'),
        '_templates',
        *path[0..-2],
        "#{path.last}.#{format}.erb"
      )
    end
  end
end
