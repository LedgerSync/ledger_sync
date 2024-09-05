# frozen_string_literal: true

module ResourceHelpers
  def test_resource_class_name
    "#{test_run_id}TestCustomResource#{test_resource_counter_increment!}"
  end

  def new_resource_class(args = {}) # rubocop:disable Metrics/CyclomaticComplexity
    class_name = args.fetch(:name, test_resource_class_name)

    remove_customer_resource_class(class_name: class_name)

    Object.const_set(
      class_name,
      Class.new(LedgerSync::Resource) do
        attr_accessors = args.fetch(:attr_accessors, [])
        attr_accessors = Array(attr_accessors)
        attr_accessors.each do |a|
          attr_accessor a
        end

        attributes = args.fetch(:attributes, [])
        attributes = Array(attributes)
        attributes.each do |a|
          a = Array(a)
          attribute a[0], **{ type: LedgerSync::Type::String }.merge(a[1] || {})
        end

        reference_class = args.fetch(:reference_class, LedgerSync::Resource)

        references_one = args.fetch(:references_one, [])
        references_one = Array(references_one)
        references_one.each do |a|
          a = Array(a)
          references_one a[0], **{ to: reference_class }.merge(a[1] || {})
        end

        references_manies = args.fetch(:references_many, [])
        references_manies = Array(references_manies)
        references_manies.each do |a|
          a = Array(a)
          references_many a[0], **{ to: reference_class }.merge(a[1] || {})
        end
      end
    )
  end

  def remove_customer_resource_class(args = {})
    class_name = args.fetch(:class_name)

    begin
      Object.send(:remove_const, class_name)
    rescue NameError
      nil
    end
  end

  def test_resource_counter_increment!
    @test_resource_counter ||= 0
    @test_resource_counter += 1
  end
end

RSpec.configure do |config|
  config.include ResourceHelpers
end
