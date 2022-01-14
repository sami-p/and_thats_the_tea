require 'rails_helper'

RSpec.describe "Subscriptions API" do
  describe '#create' do
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

    it 'will not create a subscription without a valid customer ID' do
      customer = create(:customer)
      subscription_params = ({
                              title: Faker::Hipster.sentence(word_count: 1),
                              price: 29.99,
                              status: "active",
                              frequency: Faker::Subscription.subscription_term
                             })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)

      expect(response).to_not be_successful
      expect(customer.subscriptions.count).to eq(0)
    end
  end

  describe '#update' do
    it "can cancel an existing subscription" do
      customer = create(:customer)

      tea_1 = create(:tea)
      tea_2 = create(:tea)
      tea_3 = create(:tea)

      subscription = create(:subscription)

      subscription_tea_1 = SubscriptionTea.create!(subscription_id: subscription.id, tea_id: tea_1.id)
      subscription_tea_2 = SubscriptionTea.create!(subscription_id: subscription.id, tea_id: tea_2.id)
      subscription_tea_3 = SubscriptionTea.create!(subscription_id: subscription.id, tea_id: tea_3.id)

      status = Subscription.last.status

      subscription_params = ({ status: "cancelled" })

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/subscriptions/#{subscription.id}", headers: headers, params: JSON.generate(subscription: subscription_params)

      cancelled_subscription = Subscription.find_by(id: subscription.id)

      expect(response).to be_successful
      expect(cancelled_subscription.status).to eq("cancelled")
    end
  end
end
