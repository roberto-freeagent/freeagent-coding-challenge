require 'json'

class EuroFxImporter < FxImporter
  def self.import_rates(file_path, from_currency)
    json_file = File.read(file_path)
    fx_data_hash = JSON.parse(json_file)

    fx_data_hash.each do |date, rates|
      parsed_date = Date.parse(date)
      calculate_rates(date, from_currency, rates)
    end
  end
end
