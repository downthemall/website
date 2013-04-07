require 'model_spec_helper'
require 'activemerchant'

describe PaypalNotification do

  describe "#process!" do
    subject { PaypalNotification.new('raw_post') }
    let(:notification) { stub('Notification', transaction_id: "trans", params: { 'custom' => 'foo' }) }
    let(:donation) { stub('Donation').as_null_object }

    before do
      subject.stub(:notification).and_return(notification)
      Donation.stub(:find).with('foo').and_return(donation)
    end

    context "when notification is acknowledged" do
      before do
        notification.stub(:acknowledge).and_return(true)
      end

      it "copies the transaction ID" do
        donation.should_receive(:transaction_id=).with('trans')
        subject.process!
      end

      context "when notification is marked as complete" do
        before { notification.stub(:complete?).and_return(true) }

        it "marks the donation as done" do
          donation.should_receive(:status=).with(Donation::STATUS_DONE)
          subject.process!
        end

        it "saves the donation" do
          donation.should_receive(:save)
          subject.process!
        end
      end

      context "when an exception is raised" do
        before { notification.stub(:complete?).and_raise }

        it "marks the donation as failed, with a reason" do
          donation.should_receive(:status=).with(Donation::STATUS_FAILED)
          donation.should_receive(:fail_reason=) do |reason|
            expect(reason[:message]).not_to be_blank
            expect(reason[:backtrace]).not_to be_blank
          end
          subject.process!
        end

        it "saves the donation" do
          donation.should_receive(:save)
          subject.process!
        end
      end

    end
  end

  it "works in integration" do
    ActiveMerchant::Billing::Base.mode = :test
    VCR.use_cassette('donation') do
      donation = Fabricate(:donation)
      body = "mc_gross=5.00&protection_eligibility=Ineligible&payer_id=PR59WL3Q4ULBS&tax=0.00&payment_date=06%3A10%3A29+Mar+02%2C+2013+PST&payment_status=Completed&charset=windows-1252&first_name=Test&mc_fee=0.47&notify_version=3.7&custom=1&payer_status=verified&business=vendo_1321197264_biz%40gmail.com&quantity=1&verify_sign=AXgS86tGvSMIqfh4tfmZ2KzWdSE3AOynp.Mcdt378QYIMeQx5XBmbSwt&payer_email=compro_1321197217_per%40gmail.com&txn_id=53Y12314WR4111134&payment_type=instant&last_name=User&receiver_email=vendo_1321197264_biz%40gmail.com&payment_fee=0.47&receiver_id=T4MGUTJ7MRKES&txn_type=web_accept&item_name=Downthemall+Donation&mc_currency=USD&item_number=&residence_country=IT&test_ipn=1&handling_amount=0.00&transaction_subject=6&payment_gross=5.00&shipping=0.00&ipn_track_id=965dfd3ed4a4d"
      PaypalNotification.new(body).process!
      donation.reload
      expect(donation.transaction_id).to eq("53Y12314WR4111134")
      expect(donation.status).to eq(Donation::STATUS_DONE)
    end
  end

end

