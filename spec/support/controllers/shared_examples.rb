shared_examples_for 'non-logged users' do
  it "requires non-logged users" do
    controller.should_receive(:require_non_signed_in_user!)
    action!
  end
end

shared_examples_for 'logged users' do
  it "requires logged-in users" do
    controller.should_receive(:require_signed_in_user!)
    action!
  end
end
