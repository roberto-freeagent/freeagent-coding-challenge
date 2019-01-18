require_relative '../spec_helper'

RSpec.describe FxImporter do
  let(:json_path) { './spec/fixtures/eu_rates.json' }
  let(:from_currency) { 'EUR' }

  describe '.import_json_file' do
    before { described_class.import_json_file(json_path, from_currency) }

    it 'imports the correct number of rates to the database' do
      expect(ExchangeRate.count).to eq(6)
    end

    it 'imports the given rates' do
      usd_rate = ExchangeRate.where(from_currency: 'EUR', to_currency: 'USD').first
      gbp_rate = ExchangeRate.where(from_currency: 'EUR', to_currency: 'GBP').first

      expect(usd_rate.rate).to eq(1.1403)
      expect(gbp_rate.rate).to eq(0.67)
    end

    it 'inverts the given rates' do
      gbp_inverted = ExchangeRate.where(from_currency: 'GBP', to_currency: 'EUR').first
      usd_inverted = ExchangeRate.where(from_currency: 'USD', to_currency: 'EUR').first

      expect(gbp_inverted.rate).to eq(1.4925)
      expect(usd_inverted.rate).to eq(0.877)
    end

    it 'creates the cross rates' do
    end
  end
end
