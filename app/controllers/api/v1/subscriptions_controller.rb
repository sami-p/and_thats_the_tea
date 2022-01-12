class Api::V1::SubscriptionsController < ApplicationController
  def create
    render json: Subscription.create(subscription_params)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id)
  end
end
