class DonationsController < ApplicationController
  inherit_resources
  actions :all, :except => [:index, :destroy]
  custom_actions resource: [:success, :cancel]
  before_filter :set_donation_amounts

  respond_to :js, only: [:create, :update]

  def create
    @donation = Donation.new(params[:donation])
    @donation.user = current_user
    @donation.status = :started
    @donation.payment_method = :paypal
    @donation.save
    respond_with @donation
  end

  def cancel
    @donation = Donation.find(params[:id])
    @donation.public = true
    @donation.status = :canceled
    @donation.save
    redirect_to new_donation_path
  end

  def notify
    notify = Paypal::Notification.new(request.raw_post)
    donation = Donation.find(notify.item_id)

    if notify.acknowledge
      donation.update_attributes(
        :amount => notify.amount,
        :confirmation => notify.transaction_id,
        :status => notify.status,
        :test => notify.test?
      )
      begin
        if notify.complete?
          donation.status = notify.status
        else
          logger.error("Failed to verify Paypal's notification, please investigate")
        end
      rescue => e
        donation.status = :error
        raise
      ensure
        donation.save
      end
    end
    render :nothing => true
  end

  private

  def set_donation_amounts
    @donation_amounts = Donation.amounts
  end

end
