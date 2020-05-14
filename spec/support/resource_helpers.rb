# frozen_string_literal: true

module ResourceHelpers
  def new_resource_class(args = {})
    @test_resource_counter ||= 0
    @test_resource_counter += 1

    class_name = args.fetch(:name, "#{test_run_id}TestCustomResource#{@test_resource_counter}")

    begin
      Object.send(:remove_const, class_name)
    rescue NameError
      nil
    end

    Object.const_set(
      class_name,
      Class.new(LedgerSync::Resource) do
        attr_accessors = args.fetch(:attr_accessors, [])
        attr_accessors = [attr_accessors] unless attr_accessors.is_a?(Array)
        attr_accessors.each do |a|
          attr_accessor a
        end

        attributes = args.fetch(:attributes, [])
        attributes = [attributes] unless attributes.is_a?(Array)
        attributes.each do |a|
          a = [a] unless a.is_a?(Array)
          attribute a[0], { type: LedgerSync::Type::String }.merge(a[1] || {})
        end

        references_one = args.fetch(:references_one, [])
        references_one = [references_one] unless references_one.is_a?(Array)
        references_one.each do |a|
          a = [a] unless a.is_a?(Array)
          references_one a[0], { to: LedgerSync::Resource }.merge(a[1] || {})
        end

        references_many = args.fetch(:references_many, [])
        references_many = [references_many] unless references_many.is_a?(Array)
        references_many.each do |a|
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
