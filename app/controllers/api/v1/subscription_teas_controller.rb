class Api::V1::SubscriptionTeasController < ApplicationController
  def create
    subscription = Subscription.find(params[:subscription_id])
    tea = Tea.find(params[:tea_id])
    subscription_tea = SubscriptionTea.create!(tea_id: tea.id, subscription_id: subscription.id)
  end
end
