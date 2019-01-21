class ExchangeRateCalculator
  BASE_CURRENCY = 'EUR'.freeze

  def self.calculate_rate(date, from_currency, to_currency)
    if base_calculation?(from_currency, to_currency)
      rate = find_rate(date, BASE_CURRENCY, to_currency)
      errors?(rate)

      rate.rate.round(4)
    elsif inverse_calculation?(from_currency, to_currency)
      rate = find_rate(date, BASE_CURRENCY, from_currency)
      errors?(rate)

      invert_rate(rate.rate).round(4)
    else
      from_rate = find_rate(date, BASE_CURRENCY, from_currency)
      to_rate = find_rate(date, BASE_CURRENCY, to_currency)
      errors?(from_rate)
      errors?(to_rate)

      calculate_cross_rate(from_rate.rate, to_rate.rate).round(4)
    end
  end

  class NoRateForDateError < StandardError; end
  class RateCalculationError < StandardError; end

  private

  def self.base_calculation?(from_currency, to_currency)
    from_currency == BASE_CURRENCY
  end

  def self.inverse_calculation?(from_currency, to_currency)
    to_currency == BASE_CURRENCY
  end

  def self.find_rate(date, from_currency, to_currency)
    ExchangeRate.find_by(date: date, from_currency: from_currency, to_currency: to_currency)
  end

  def self.invert_rate(rate)
    (1/rate)
  end

  def self.calculate_cross_rate(from_rate, to_rate)
    to_rate / from_rate
  end

  def self.errors?(rate)
    raise NoRateForDateError unless rate
    raise RateCalculationError unless rate.rate
  end
end
