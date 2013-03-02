class PaypalNotification
  attr_reader :request_body

  def initialize(request_body)
    @request_body = request_body
  end

  def process!
    notification.tap do |n|
      donation = Donation.find(n.params['custom'])
      if n.acknowledge
        begin
          donation.transaction_id = n.transaction_id
          if n.complete?
            donation.status = Donation::STATUS_DONE
          else
            raise "Notification not marked as complete"
          end
        rescue Exception => e
          donation.status = Donation::STATUS_FAILED
          donation.fail_reason = {
            message: e.message,
            backtrace: e.backtrace
          }
        ensure
          donation.save
        end
      else
        raise "Invalid"
      end
    end
  end

  def notification
    @notification ||= ActiveMerchant::Billing::Integrations::Paypal::Notification.new(request_body)
  end
end
