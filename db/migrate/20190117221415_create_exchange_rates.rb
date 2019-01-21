class CreateExchangeRates < ActiveRecord::Migration[5.2]
  def change
    create_table :exchange_rates do |t|
      t.string :from_currency, null: false
      t.string :to_currency, null: false
      t.float :rate
      t.datetime :date, null: false
    end
  end
end
