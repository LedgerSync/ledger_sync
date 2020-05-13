# frozen_string_literal: true

module ResourceHelpers
  def new_resource_class(args = {})
    class_name = args.fetch(:name, "#{test_run_id}TestCustomResource")

    begin
      Object.send(:remove_const, class_name)
    rescue NameError
      nil
    end

    Object.const_set(
      class_name,
      Class.new(LedgerSync::Resource) do
        args.fetch(:attributes, []).each do |a|
          a = [a] unless a.is_a?(Array)
          attribute a[0], { type: LedgerSync::Type::String }.merge(a[1] || {})
        end
        args.fetch(:references_one, []).each do |a|
          a = [a] unless a.is_a?(Array)
          references_one a[0], { to: LedgerSync::Resource }.merge(a[1] || {})
        end
        args.fetch(:references_many, []).each do |a|
          a = [a] unless a.is_a?(Array)
          references_many a[0], { to: LedgerSync::Resource }.merge(a[1] || {})
        end
      end
    )
  end
end

RSpec.configure do |config|
  config.include ResourceHelpers
end