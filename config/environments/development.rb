require_relative '../lib/freeagent_coding_challenge'

db_config = YAML.load_file('./db/config.yml')
ActiveRecord::Base.establish_connection(db_config['development'])
