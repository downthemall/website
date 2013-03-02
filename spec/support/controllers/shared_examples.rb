shared_examples_for 'non-logged users' do
  it "requires non-logged users" do
    controller.stub(:current_user).and_return('user')
    action!
    flash[:alert].should_not be_blank
    redirect_url.should == controller.url(:index)
  end
end

shared_examples_for 'logged users' do
  it "requires logged-in users" do
    controller.stub(:current_user).and_return(nil)
    action!
    flash[:alert].should_not be_blank
    redirect_url.should == controller.url(:index)
  end
end

