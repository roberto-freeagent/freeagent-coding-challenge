class ExchangeRate < ActiveRecord::Base
  has_one :currency
end
