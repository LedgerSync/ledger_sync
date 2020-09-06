# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class Record
      attr_reader :hash, :ledger_id, :ledger_class, :ledger_resource,
                  :request_hash, :update_request_hash, :response_hash,
                  :search_url

      def initialize(args = {})
        @hash = args.fetch(:hash)

        @ledger_id = hash.fetch(:ledger_id, nil)
        @ledger_resource = hash.fetch(:ledger_resource, nil)
        @ledger_class = hash.fetch(:ledger_class)
        @request_hash = hash.fetch(:request_hash, nil)
        @update_request_hash = hash.fetch(:update_request_hash, nil)
        @response_hash = hash.fetch(:response_hash, nil)
        @search_url = hash.fetch(:search_url, nil)
      end
    end

    class RecordCollection
      attr_reader :dir, :records

      def initialize(args = {})
        @dir = args.fetch(:dir, File.join(LedgerSync.root, '/spec/support/quickbooks_online/records'))
        @records = {}

        # Process json files
        Gem.find_files(File.join(dir, '*.rb')).map do |file_path|
          record_name = File.basename(file_path, '.rb')
          require_relative "records/#{record_name}"

          record = "Test::QuickBooksOnline::#{record_name.titleize.tr(' ', '')}".constantize.stub
          @records[record_name] = Record.new(hash: record)
          # self.class.define_method(record) do
          #   records[record]
          # end
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
