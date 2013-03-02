require 'spec_helper'

describe DonationsController do
  let(:donation) { double('Donation').as_null_object }

  describe 'GET /donate' do
    let(:action!) { get :new }
    it "assigns a new donation" do
      Donation.stub(:new).and_return(donation)
      action!
      assigns[:donation].should == donation
    end
    it "renders" do
      action!
      rendered_view.should == 'donations/new'
    end
  end

  describe 'POST /donate' do
    let(:action!) { post :create, donation: 'foo' }
    before { Donation.stub(:new).with('foo').and_return(donation) }
    it "creates and assigns a new donation" do
      action!
      assigns[:donation].should == donation
    end
    it "sets the donation as pending" do
      donation.should_receive(:status=).with(Donation::STATUS_PENDING)
      action!
    end
    context "when the donation is saved" do
      it "renders" do
        donation.stub(:save).and_return(true)
        action!
        rendered_view.should == 'donations/create'
      end
    end
    context "else" do
      it "renders" do
        donation.stub(:save).and_return(false)
        action!
        rendered_view.should == 'donations/new'
      end
    end
  end

  describe 'POST /paypal_notify' do
    let(:action!) { post :paypal_notify }
    it "forwards the processing to PaypalNotification" do
      notification = stub
      PaypalNotification.stub(:new).with('foo').and_return(notification)
      controller.request = stub(body: stub(read: 'foo'))
      notification.should_receive(:process!)
      action!
    end
  end

  describe 'POST /complete/:id' do
    let(:action!) { post :complete, id: 'foo' }
    before { Donation.stub(:find).with('foo').and_return(donation) }
    it "assigns the donation" do
      action!
      assigns[:donation].should == donation
    end
    it "adds a notice" do
      action!
      flash.now[:notice].should_not be_blank
    end
    it "renders" do
      action!
      rendered_view.should == 'donations/complete'
    end
  end

  describe 'GET /cancel/:id' do
    let(:action!) { get :cancel, id: 'foo' }
    before { Donation.stub(:find).with('foo').and_return(donation) }
    it "marks the donation as canceled" do
      donation.should_receive(:cancel!)
      action!
    end
    it "adds an alert" do
      action!
      flash[:alert].should_not be_blank
    end
    it "redirects to a new donation" do
      action!
      redirect_url.should == controller.url(:donations, :new)
    end
  end

end

