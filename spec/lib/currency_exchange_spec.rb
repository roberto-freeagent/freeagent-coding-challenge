require 'spec_helper'

RSpec.describe CurrencyExchange do
  describe '.rate' do
    context 'with a valid date, from_currency and to_currency' do
      let!(:exchange_rate) { ExchangeRate.create(from_currency: 'EUR', to_currency: 'USD', date: Date.new(2018, 11, 22), rate: 0.57) }

      it 'returns the exchange rate between from_currency and to_currency' do
        expect(described_class.rate(Date.new(2018, 11, 22), 'EUR', 'USD')).to eq(0.57)
      end
    end

    context 'with a from currency that isnt the base currency' do
      let!(:usd_rate) { ExchangeRate.create(from_currency: 'EUR', to_currency: 'USD', date: Date.new(2018, 11, 22), rate: 0.57) }
      let!(:gbp_rate) { ExchangeRate.create(from_currency: 'EUR', to_currency: 'GBP', date: Date.new(2018, 11, 22), rate: 0.68)}

      it 'returns the exchange rate between from_currency and to_currency' do
        expect(described_class.rate(Date.new(2018, 11, 22), 'USD', 'GBP')).to eq(1.193)
      end
    end

    context 'when the rate doesnt exist for a given date' do
      it 'raises an error' do
        expect { described_class.rate(Date.new(2018, 11, 22), 'EUR', 'USD') }.to raise_exception(ExchangeRate::NoRateForDateError)
      end
    end

    context 'with a nil rate' do
      let!(:exchange_rate) { ExchangeRate.create(from_currency: 'EUR', to_currency: 'USD', date: Date.new(2018, 11, 22), rate: nil) }

      it 'raises an error' do
        expect { described_class.rate(Date.new(2018, 11, 22), 'EUR', 'USD') }.to raise_exception(ExchangeRate::RateCalculationError)
      end
    end
  end
end
