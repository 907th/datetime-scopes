require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "rspec/core"
require "database_cleaner"
require "datetime-scopes"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
DatabaseCleaner.strategy = :truncation

RSpec.configure do |c|
  c.before :suite do
    DatabaseCleaner.clean
  end
  c.after :example do
    DatabaseCleaner.clean
  end
end


# Create table and declare AR model

ActiveRecord::Migration.verbose = false
ActiveRecord::Migration.create_table :foo_bar do |t|
  t.datetime :foo
  t.date :bar
end

class FooBar < ActiveRecord::Base
  datetime_scopes :foo
  date_scopes :bar
end
