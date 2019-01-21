class FxImporter
  def self.invert_rate(rate)
    (1/rate).round(4)
  end

  def self.calculate_rates(date, from_currency, rates)
    rates.each do |to_currency, rate|
      create_rates(date, from_currency, to_currency, rate)
      rates.delete(to_currency)
      create_cross_rates(date, to_currency, rate, rates)
    end
  end

  def self.create_cross_rates(date, to_currency, rate, other_rates)
    other_rates.each do |other_currency, other_rate|
      cross_rate = other_rate/rate
      create_rates(date, to_currency, other_currency, cross_rate)
    end
  end

  def self.create_rates(date, from_currency, to_currency, rate)
    ExchangeRate.create(date: date, from_currency: from_currency, to_currency: to_currency, rate: rate)
    ExchangeRate.create(date: date, from_currency: to_currency, to_currency: from_currency, rate: invert_rate(rate))
  end
end
