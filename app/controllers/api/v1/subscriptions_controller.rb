class Api::V1::SubscriptionsController < ApplicationController
  def create
    customer = Customer.find(subscription_params[:customer_id])
    if !customer.nil?
      subscription = Subscription.new(subscription_params)
      subscription.save
      render json: SubscriptionSerializer.new(subscription)
    else
      render json: error('Customer not found.')
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id)
  end
end
