require 'spec_helper'

RSpec.describe ExchangeRateCalculator do
  describe '.calculate_rate' do
    context 'with a valid date, from_currency and to_currency' do
      let!(:exchange_rate) { ExchangeRate.create(from_currency: 'EUR', to_currency: 'USD', date: Date.new(2018, 11, 22), rate: 0.57) }

      it 'returns the exchange rate between from_currency and to_currency' do
        expect(described_class.calculate_rate(Date.new(2018, 11, 22), 'EUR', 'USD')).to eq(0.57)
      end
    end

    context 'with a ' do

    end

    context 'with a from currency that isnt the base currency' do
      let!(:usd_rate) { ExchangeRate.create(from_currency: 'EUR', to_currency: 'USD', date: Date.new(2018, 11, 22), rate: 1.13670) }
      let!(:gbp_rate) { ExchangeRate.create(from_currency: 'EUR', to_currency: 'GBP', date: Date.new(2018, 11, 22), rate: 0.882294)}

      it 'calculates the inverse rate correctly' do
        expect(described_class.calculate_rate(Date.new(2018,11,22), 'USD', 'EUR')).to eq(0.8797)
      end

      it 'calculates the cross rate correctly' do
        expect(described_class.calculate_rate(Date.new(2018, 11, 22), 'USD', 'GBP')).to eq(0.7762)
      end
    end

    context 'when the rate doesnt exist for a given date' do
      it 'raises an error' do
        expect { described_class.calculate_rate(Date.new(2018, 11, 22), 'EUR', 'USD') }.to raise_exception(ExchangeRateCalculator::NoRateForDateError)
      end
    end

    context 'with a nil rate' do
      let!(:exchange_rate) { ExchangeRate.create(from_currency: 'EUR', to_currency: 'USD', date: Date.new(2018, 11, 22), rate: nil) }

      it 'raises an error' do
        expect { described_class.calculate_rate(Date.new(2018, 11, 22), 'EUR', 'USD') }.to raise_exception(ExchangeRateCalculator::RateCalculationError)
      end
    end
  end
end
