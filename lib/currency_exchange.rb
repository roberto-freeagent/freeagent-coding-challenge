class CurrencyExchange
  def self.rate(date, from_currency, to_currency)
    ExchangeRateCalculator.calculate_rate(date, from_currency, to_currency)
  end
end
