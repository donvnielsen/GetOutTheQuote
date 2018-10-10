require 'ruby-progressbar'
require 'sqlite3'
require 'yaml'
require 'pp'

ENV['RAILS_ENV'] = 'dev'

require_relative '../config/environment'
require_relative '../app/models/source'
require_relative '../app/models/qty_views'
require_relative '../app/models/quotation'

ActiveRecord::Base.establish_connection(
  adapter: CONFIG_DB['adapter'],
  database: File.join(ROOT_DIR, CONFIG_DB['database'])
)

100.times do |i|
  views = QtyViews.where(sourceid: Source.find(rand(1..4)).id)
  onlymins = views.where(views: views.minimum(:views))
  selectedquote = Quotation.find(onlymins[rand(onlymins.count)].quoteid)
  selectedquote.update_attribute(:views, selectedquote.views + 1).to_s
end