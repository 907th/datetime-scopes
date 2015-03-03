require "rspec/core"
require "database_cleaner"
require "activerecord-time-scope"

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

RSpec.configure do |c|
  c.before :suite do
    ActiveRecord::Migration.verbose = false
    DatabaseCleaner.clean_with :truncation
  end
  c.before :example do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end
  c.after :example do
    DatabaseCleaner.clean
  end
end
