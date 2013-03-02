class DonationsController < Controller

  get :new, map: '/donate' do
    @donation = Donation.new(amount: 10)
    render 'donations/new'
  end

  post :create do
    @donation = Donation.new(params[:donation])
    @donation.status = Donation::STATUS_PENDING
    if @donation.save
      render 'donations/create'
    else
      render 'donations/new'
    end
  end

  post :paypal_notify do
    PaypalNotification.new(request.body.read).process!
    "Processed."
  end

  post :complete, with: :id do
    @donation = Donation.find(params[:id])
    flash.now[:notice] = I18n.t('donations.completed')
    render 'donations/complete'
  end

  get :cancel, with: :id do
    Donation.find(params[:id]).cancel!
    flash[:alert] = I18n.t('donations.canceled')
    redirect url(:donations, :new)
  end
end

Downthemall.controller :donations do
  DonationsController.install_routes!(self)
end

