require 'spec_helper'

describe DonationsController do
  let(:donation) { double('Donation').as_null_object }

  describe 'GET /donate' do
    let(:action!) { get :new }
    it "assigns a new donation" do
      Donation.stub(:new).and_return(donation)
      action!
      expect(assigns[:donation]).to eq(donation)
    end
    it "renders" do
      action!
      expect(rendered_view).to eq('donations/new')
    end
  end

  describe 'POST /donate' do
    let(:action!) { post :create, donation: 'foo' }
    before { Donation.stub(:new).with('foo').and_return(donation) }
    it "creates and assigns a new donation" do
      action!
      expect(assigns[:donation]).to eq(donation)
    end
    it "sets the donation as pending" do
      donation.should_receive(:status=).with(Donation::STATUS_PENDING)
      action!
    end
    context "when the donation is saved" do
      it "renders" do
        donation.stub(:save).and_return(true)
        action!
        expect(rendered_view).to eq('donations/create')
      end
    end
    context "else" do
      it "renders" do
        donation.stub(:save).and_return(false)
        action!
        expect(rendered_view).to eq('donations/new')
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
      expect(assigns[:donation]).to eq(donation)
    end
    it "adds a notice" do
      action!
      expect(flash.now[:notice]).not_to be_blank
    end
    it "renders" do
      action!
      expect(rendered_view).to eq('donations/complete')
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
      expect(flash[:alert]).not_to be_blank
    end
    it "redirects to a new donation" do
      action!
      expect(redirect_url).to eq(controller.url(:donations, :new))
    end
  end

end

