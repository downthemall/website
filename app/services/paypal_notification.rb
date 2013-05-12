class PaypalNotification
  attr_reader :request_body

  def initialize(request_body)
    @request_body = request_body
  end

  def process!
    raise "Donation does not exists" unless donation.present?
    raise "Invalid request" unless notification.acknowledge
    update_donation!
    donation
  end

  def update_donation!
    raise "Notification not marked as complete" unless notification.complete?
    donation.transaction_id = notification.transaction_id
    donation.status = Donation::STATUS_DONE
  rescue Exception => e
    donation.status = Donation::STATUS_FAILED
    donation.fail_reason = { message: e.message, backtrace: e.backtrace }
  ensure
    donation.save
  end

  def donation
    @donation ||= Donation.find(notification.params['custom'])
  end

  def notification
    @notification ||= ActiveMerchant::Billing::Integrations::Paypal::Notification.new(request_body)
  end
end

