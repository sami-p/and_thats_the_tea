require 'rails_helper'

describe "Subscriptions API" do
  it "can create a new subscription" do
    customer = create(:customer)

    subscription_params = ({
                            title: Faker::Hipster.sentence(word_count: 1),
                            price: 29.99,
                            status: "active",
                            frequency: Faker::Subscription.subscription_term,
                            customer_id: customer.id
                           })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)

    created_subscription = Subscription.last

    expect(response).to be_successful
    expect(created_subscription.title).to eq(subscription_params[:title])
    expect(created_subscription.price).to eq(subscription_params[:price])
    expect(created_subscription.status).to eq(subscription_params[:status])
    expect(created_subscription.frequency).to eq(subscription_params[:frequency])
  end

  # Add sad path for no existing customer

  it "can cancel an existing subscription" do
    customer = create(:customer)
    subscription = create(:subscription).id
    status = Subscription.last.status
    subscription_params = ({ status: "cancelled" })

    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/subscriptions/#{subscription}", headers: headers, params: JSON.generate(subscription: subscription_params)

    cancelled_subscription = Subscription.find_by(id: subscription)

    expect(response).to be_successful
    expect(cancelled_subscription.status).to eq("cancelled")
    # Change frequency based on status ?
  end

  # Add sad path for non-valid ID
end
