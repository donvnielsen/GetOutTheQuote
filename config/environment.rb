require 'logger'
require 'yaml'

ROOT_DIR = File.expand_path(File.join(File.dirname(__FILE__),'..'))
CONFIG_DIR = File.expand_path(File.join(ROOT_DIR,'config'))

CONFIG = YAML::load(File.open(File.join(CONFIG_DIR,'config.yml')))[ENV['RAILS_ENV']]
CONFIG_DB = YAML::load(File.open(File.join(CONFIG_DIR,'config_db.yml')))[ENV['RAILS_ENV']]

PROGRESS_BAR_OPTIONS = {fmt: '%t |%B| %c of %C %p%%', lg: 80}

