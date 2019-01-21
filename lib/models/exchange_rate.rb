class ExchangeRate < ActiveRecord::Base
  BASE_CURRENCY = 'EUR'

  def self.fetch_rate(date, from_currency, to_currency)
    if from_currency == BASE_CURRENCY
      rate = find_by(date: date, from_currency: BASE_CURRENCY, to_currency: to_currency)
      raise NoRateForDateError unless rate
      raise RateCalculationError unless rate.rate

      rate.rate.round(4)
    elsif to_currency == BASE_CURRENCY
      rate = find_by(date: date, from_currency: BASE_CURRENCY, to_currency: from_currency)
      raise NoRateForDateError unless rate
      raise RateCalculationError unless rate.rate

      invert_rate(rate.rate).round(4)
    else
      from_rate = find_by(date: date, from_currency: BASE_CURRENCY, to_currency: from_currency)
      to_rate = find_by(date: date, from_currency: BASE_CURRENCY, to_currency: to_currency)
      raise NoRateForDateError unless from_rate && to_rate
      raise RateCalculationError unless from_rate.rate && to_rate.rate

      calculate_cross_rate(from_rate.rate, to_rate.rate).round(4)
    end
  end

  class NoRateForDateError < StandardError; end
  class RateCalculationError < StandardError; end

  private

  def self.invert_rate(rate)
    (1/rate)
  end

  def self.calculate_cross_rate(from_rate, to_rate)
    to_rate / from_rate
  end
end
