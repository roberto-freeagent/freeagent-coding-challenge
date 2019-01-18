require 'spec_helper'

RSpec.describe CurrencyExchange do
  describe '.rate' do
    context 'with a valid date, from_currency and to_currency' do
      let!(:exchange_rate) { ExchangeRate.create(from_currency: 'EUR', to_currency: 'USD', date: Date.new(2018, 11,22), rate: 0.57) }

      it 'returns the exchange rate between from_currency and to_currency' do
        expect(described_class.rate(Date.new(2018, 11, 22), 'EUR', 'USD')).to eq(0.57)
      end
    end
  end
end
