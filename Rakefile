require 'active_record'
require 'standalone_migrations'
require_relative './lib/freeagent_coding_challenge'
StandaloneMigrations::Tasks.load_tasks

namespace :fx do
  desc 'Import the exchange rates from the file'
  task :import do
    FxParser.parse_json_file('./data/eurofxref-hist-90d.json')
  end
end
