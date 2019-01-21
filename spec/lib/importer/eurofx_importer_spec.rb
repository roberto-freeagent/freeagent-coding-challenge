require_relative '../../spec_helper'

RSpec.describe EuroFxImporter do
  let(:json_path) { './spec/fixtures/eu_rates.json' }
  let(:from_currency) { 'EUR' }

  describe '.import_json_file' do
    before { described_class.import_rates(json_path, from_currency) }

    it 'imports the correct number of rates to the database' do
      expect(ExchangeRate.count).to eq(2)
    end
  end
end
