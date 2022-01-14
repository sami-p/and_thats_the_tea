class Api::V1::CustomersController < ApplicationController
  def show
    customer = Customer.find(params[:id])
    require "pry"; binding.pry
    subscriptions = customer.subscriptions
  end
end
