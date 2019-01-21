require 'spec_helper'
require 'rake'
require_relative '../../lib/tasks/importer'

RSpec.describe 'fx:import' do
  let!(:file_path) { './data/eurofxref-hist-90d.json' }
  let!(:base_currency) { 'EUR' }

  context 'with correct arguments' do
    it 'calls the EuroFxImporter' do
      expect(EuroFxImporter).to receive(:import_rates).with('./data/eurofxref-hist-90d.json', 'EUR')

      Rake.application.invoke_task "fx:import[#{file_path}, #{base_currency}]"
    end
  end

  context 'without correct arguments' do
    it 'does not call the EuroFxImporter' do
      expect(EuroFxImporter).not_to receive(:import_rates)

      Rake.application.invoke_task "fx:import"
    end
  end
end
