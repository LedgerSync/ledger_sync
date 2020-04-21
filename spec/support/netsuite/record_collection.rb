# frozen_string_literal: true

module Test
  module NetSuite
    class Record
      attr_reader :hash, :id, :path

      def initialize(args = {})
        @hash = args.fetch(:hash)
        @path = args.fetch(:path)

        @id = hash.fetch('id', nil)
      end
    end

    class RecordCollection
      attr_reader :dir, :records

      def initialize(args = {})
        # @dir = args.fetch(:dir, File.join(LedgerSync.root, '/spec/support/netsuite/records/**/*.json'))
        @dir = args.fetch(:dir, File.join(LedgerSync.root, '/spec/support/netsuite/records'))
        @records = {}

        # Process json files
        Gem.find_files(File.join(dir, '*.json')).map do |file_path|
          record = File.basename(file_path, '.json').to_sym
          @records[record] = Record.new(
            hash: JSON.parse(File.open(file_path).read),
            path: file_path
          )
          self.class.define_method(record) do
            records[record]
          end
        end

        # Process directories
        Dir.chdir(dir) do
          Dir.glob('*').select { |f| File.directory? f }.each do |sub_dir|
            sub_dir_path = File.join(dir, sub_dir)
            next if Gem.find_files(File.join(sub_dir_path, '**/*.json')).empty?

            @records[sub_dir.to_sym] = RecordCollection.new(dir: sub_dir_path)
            self.class.define_method(sub_dir) do
              records[sub_dir.to_sym]
            end
          end
        end
      end

      def all
        @all ||= begin
          ret = {}
          records.each do |k, v|
            if v.is_a?(self.class)
              v.all.each do |sub_k, sub_v|
                ret[[k, sub_k].join('/').to_s] = sub_v
              end
            else
              ret[k.to_s] = v
            end
          end
          ret
        end
      end
    end
  end
end
