require 'rails_helper'

describe "Subscription Teas API" do
  it "can create a new subscription tea" do
    customer = create(:customer)
    tea = create(:tea)
    
    subscription = create(:subscription, customer_id: customer.id)

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/subscription_teas", headers: headers, params: JSON.generate(subscription_id: subscription.id, tea_id: tea.id)

    expect(response).to be_successful
  end
end
