class DonationsController < ApplicationController
  respond_to :html

  def new
    @donation = Donation.new(amount: 10)
  end

  def create
    @donation = Donation.new(donation_params)
    @donation.status = Donation::STATUS_PENDING
    @donation.save
    respond_with @donation
  end

  def paypal_notify
    PaypalNotification.new(request.body.read).process!
    render text: "Processed."
  end

  def complete
    @donation = Donation.find(params[:id])
    flash.now[:notice] = I18n.t('donations.completed')
    render 'donations/complete'
  end

  def cancel
    Donation.find(params[:id]).cancel!
    flash[:alert] = I18n.t('donations.canceled')
    redirect url(:donations, :new)
  end

  protected

  def donation_params
    params.require(:donation).permit(:donor_name, :currency, :amount)
  end
end

