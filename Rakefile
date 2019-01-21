require 'active_record'
require 'standalone_migrations'
require_relative './lib/freeagent_coding_challenge'
StandaloneMigrations::Tasks.load_tasks

namespace :fx do
  desc 'Import the exchange rates from the file'
  task :import do
    EuroFxImporter.import_rates('./data/eurofxref-hist-90d.json', 'EUR')
  end
end
