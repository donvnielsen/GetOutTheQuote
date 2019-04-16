
require 'sqlite3'
require 'yaml'
require 'pp'

ENV['RAILS_ENV'] = 'dev'

require_relative '../config/environment'

require_relative '../app/models/qty_view'
require_relative '../app/models/quotation'
require_relative '../app/models/source'
require_relative '../app/models/quote_min_view'

ActiveRecord::Base.establish_connection(
  adapter: CONFIG_DB['adapter'],
  database: File.join(ROOT_DIR, CONFIG_DB['database'])
)

sources = Source.select(:rowid)

ActiveRecord::Base.transaction do
  25.times do |i|
    min_viewed_quotes = QuoteMinView.where(viewedby: ['dvn', nil])
    quote = min_viewed_quotes.where(sourceid: sources[rand(0..sources.size - 1)]).first
    quotation = Quotation.find(quote.quoteid)
    quotation.update_attribute(:views, quotation.views + 1)
    puts "#{i}. #{quotation.sourceid}:#{quotation.id} #{quotation.quote}"
  end
end
