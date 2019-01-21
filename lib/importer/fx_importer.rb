class FxImporter
  def self.calculate_rates(date, from_currency, rates)
    rates.each do |to_currency, rate|
      create_rates(date, from_currency, to_currency, rate)
    end
  end

  def self.create_rates(date, from_currency, to_currency, rate)
    ExchangeRate.create(date: date, from_currency: from_currency, to_currency: to_currency, rate: rate.round(4))
  end
end
