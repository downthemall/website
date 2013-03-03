RSpec::Matchers.define :have_errors_on do |*attributes|
  @message = nil
  inspected_attrs = attributes.map(&:inspect).join(", ")

  chain :with_message do |message|
    @message = message
  end

  match do |model|
    model.valid?

    @has_errors = attributes.all? { |a| model.errors.include?(a) }

    if @message
      @has_errors && attributes.all? { |a| model.errors[a].include?(@message) }
    else
      @has_errors
    end
  end

  failure_message_for_should do |model|
    if @message
      "Validation errors #{model.errors.inspect} should " +
      "include \"#{@message.inspect}\" for attributes #{inspected_attrs}"
    else
      "#{model.class} should have errors on attributes #{inspected_attrs}"
    end
  end

  failure_message_for_should_not do |model|
    "#{model.class} should not have an error on attributes #{inspected_attrs}"
  end
end

