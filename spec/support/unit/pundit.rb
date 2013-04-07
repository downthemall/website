RSpec::Matchers.define :permit do |user, record, *actions|
  match do |policy|
    policy = policy.class
    actions.all? { |action| policy.new(user, record).public_send(action) }
  end

  description do
    name = if record.is_a? RSpec::Mocks::Mock
             record.instance_variable_get("@name")
           else
             record.class.name
           end
    "permit#{to_sentence(actions)} on #{name}"
  end

  failure_message_for_should do |policy|
    "Expected #{policy.to_s} to permit#{to_sentence(actions)} on #{record} but it didn't."
  end

  failure_message_for_should_not do |policy|
    "Expected #{policy.to_s} to forbid#{to_sentence(actions)} on #{record} but it didn't."
  end
end

