require 'spec_helper'

describe PaypalNotification do
  let(:body) { "mc_gross=5.00&protection_eligibility=Ineligible&payer_id=PR59WL3Q4ULBS&tax=0.00&payment_date=06%3A10%3A29+Mar+02%2C+2013+PST&payment_status=Completed&charset=windows-1252&first_name=Test&mc_fee=0.47&notify_version=3.7&custom=1&payer_status=verified&business=vendo_1321197264_biz%40gmail.com&quantity=1&verify_sign=AXgS86tGvSMIqfh4tfmZ2KzWdSE3AOynp.Mcdt378QYIMeQx5XBmbSwt&payer_email=compro_1321197217_per%40gmail.com&txn_id=53Y12314WR4111134&payment_type=instant&last_name=User&receiver_email=vendo_1321197264_biz%40gmail.com&payment_fee=0.47&receiver_id=T4MGUTJ7MRKES&txn_type=web_accept&item_name=Downthemall+Donation&mc_currency=USD&item_number=&residence_country=IT&test_ipn=1&handling_amount=0.00&transaction_subject=6&payment_gross=5.00&shipping=0.00&ipn_track_id=965dfd3ed4a4d" }
  let(:donation) { create(:donation) }
  subject { PaypalNotification.new(body) }

  before do
    create(:donation)
    Donation.stubs(:find).with('1').returns(donation)
    ActiveMerchant::Billing::Base.mode = :test
    VCR.insert_cassette('donation')
  end

  after do
    VCR.eject_cassette
  end

  context "with complete body" do
    it "marks the donation as done" do
      donation = subject.process!
      expect(donation.transaction_id).to eq("53Y12314WR4111134")
      expect(donation.status).to eq(Donation::STATUS_DONE)
    end
  end

  context "with a non-acknowledged request" do
    before do
      ActiveMerchant::Billing::Integrations::Paypal::Notification.any_instance.stubs(:acknowledge).returns(false)
    end
    it "raises an error" do
      expect do
        subject.process!
      end.to raise_error
    end
  end

  context "with non completed request" do
    before do
      ActiveMerchant::Billing::Integrations::Paypal::Notification.any_instance.stubs(:complete?).returns(false)
    end
    it "marks the donation as failed" do
      donation = subject.process!
      expect(donation.status).to eq(Donation::STATUS_FAILED)
      expect(donation.fail_reason).not_to be_blank
    end
  end
end

