require_relative '../../spec_helper'

RSpec.describe EuroFxImporter do
  let(:json_path) { './spec/fixtures/eu_rates.json' }
  let(:from_currency) { 'EUR' }

  describe '.import_json_file' do
    before { described_class.import_rates(json_path, from_currency) }

    it 'imports the correct number of rates to the database' do
      expect(ExchangeRate.count).to eq(2)
    end

    it 'imports the correct rates to the database' do
      rate_1 = ExchangeRate.find_by(date: DateTime.new(2019, 1, 17), from_currency: 'EUR', to_currency: 'USD')
      rate_2 = ExchangeRate.find_by(date: DateTime.new(2019, 1, 17), from_currency: 'EUR', to_currency: 'GBP')

      expect(rate_1).to be_a ExchangeRate
      expect(rate_1.from_currency).to eq('EUR')
      expect(rate_1.to_currency).to eq('USD')
      expect(rate_1.rate).to eq(1.13670)
      expect(rate_2).to be_a ExchangeRate
      expect(rate_2.from_currency).to eq('EUR')
      expect(rate_2.to_currency).to eq('GBP')
      expect(rate_2.rate).to eq(0.8823)
    end
  end
end
