require 'rails_helper'

RSpec.describe "Customers API", type: :request do
  describe '#show' do
    it 'lists all subscriptions for a customer' do
      customer = create(:customer)

      tea_1 = create(:tea)
      tea_2 = create(:tea)
      tea_3 = create(:tea)
      tea_4 = create(:tea)
      tea_5 = create(:tea)
      tea_6 = create(:tea)

      subscription_1 = create(:subscription, customer_id: customer.id)
      subscription_2 = create(:subscription, customer_id: customer.id)

      subscription_tea_1 = SubscriptionTea.create!(subscription_id: subscription_1.id, tea_id: tea_1.id)
      subscription_tea_2 = SubscriptionTea.create!(subscription_id: subscription_1.id, tea_id: tea_2.id)
      subscription_tea_3 = SubscriptionTea.create!(subscription_id: subscription_1.id, tea_id: tea_3.id)
      subscription_tea_4 = SubscriptionTea.create!(subscription_id: subscription_2.id, tea_id: tea_4.id)
      subscription_tea_5 = SubscriptionTea.create!(subscription_id: subscription_2.id, tea_id: tea_5.id)
      subscription_tea_6 = SubscriptionTea.create!(subscription_id: subscription_2.id, tea_id: tea_6.id)

      get "/api/v1/customers/#{customer.id}"

      expect(response.status).to eq(200)

      result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(result).to be_an Array
      expect(result.length).to eq(2)

      expect(result[0][:attributes]).to have_key(:title)
      expect(result[0][:attributes][:title]).to eq(subscription_1.title)
      
      expect(result[0][:attributes]).to have_key(:price)
      expect(result[0][:attributes][:price]).to eq(subscription_1.price)

      expect(result[0][:attributes]).to have_key(:status)
      expect(result[0][:attributes][:status]).to eq(subscription_1.status)

      expect(result[0][:attributes]).to have_key(:frequency)
      expect(result[0][:attributes][:frequency]).to eq(subscription_1.frequency)

      expect(result[0][:attributes]).to have_key(:customer_id)
      expect(result[0][:attributes][:customer_id]).to eq(customer.id)
    end
  end
end
