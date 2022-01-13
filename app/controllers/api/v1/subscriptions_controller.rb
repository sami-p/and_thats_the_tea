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

  def update
    subscription = Subscription.find(params[:id])
    if subscription.update(subscription_params)
      render json: SubscriptionSerializer.new(subscription)
    else
      render json: { error: 'ERROR: Invalid Request.' }, status: :not_found
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id)
  end
end
