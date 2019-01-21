require_relative '../../config/environments/development'

namespace :fx do
  desc 'Import the exchange rates from the file'
  task :import, [:file_path, :base_currency] do |task, args|
    if args[:file_path] && args[:base_currency]
      EuroFxImporter.import_rates(args[:file_path], args[:base_currency])
    else
      puts 'File path and base currency are required arguments'
    end
  end
end
