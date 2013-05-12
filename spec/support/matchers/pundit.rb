RSpec::Matchers.define :permit do |user, record, *actions|
  match do |policy|
    policy = policy.class
    actions.all? { |action| policy.new(user, record).public_send(action) }
  end

  description do
    name = record.class.name
    "permit#{to_sentence(actions)} on #{name}"
  end

  failure_message_for_should do |policy|
    "Expected #{policy.to_s} to permit#{to_sentence(actions)} on #{record} but it didn't."
  end

  failure_message_for_should_not do |policy|
    "Expected #{policy.to_s} to forbid#{to_sentence(actions)} on #{record} but it didn't."
  end
end

