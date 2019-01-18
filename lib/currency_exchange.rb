class CurrencyExchange
  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  def self.rate(date, from_currency, to_currency)
    ExchangeRate.find_by(date: date, from_currency: from_currency, to_currency: to_currency).rate
  end

  class NoRateForDateError < StandardError; end
  class RateCalculationError < StandardError; end
end
