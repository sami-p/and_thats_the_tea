class ChangeSubscriptionFrequencyToString < ActiveRecord::Migration[6.1]
  def change
    change_column :subscriptions, :frequency, :string
  end
end
