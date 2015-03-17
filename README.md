# Date/time scopes for ActiveRecord

[![Build Status](https://travis-ci.org/907th/activerecord-time-scope.svg?branch=master)](https://travis-ci.org/907th/activerecord-time-scope)
[![Code Climate](https://codeclimate.com/github/907th/activerecord-time-scope/badges/gpa.svg)](https://codeclimate.com/github/907th/activerecord-time-scope)
[![Test Coverage](https://codeclimate.com/github/907th/activerecord-time-scope/badges/coverage.svg)](https://codeclimate.com/github/907th/activerecord-time-scope)

Add usefull time-related scopes to your ActiveRecord model.

## Installation

Via Gemfile (using Bundler):

```ruby
# Gemfile
gem "activerecord-time-scope"
```

## Usage

### With `datetime` attributes

Use class-level `time_scope` method with the name of the attribute:

```ruby
# app/models/my_model.rb
class MyModel < ActiveRecord::Base
  time_scope :created_at
end
```

Now the model has these scopes:
* created_within(from, to)
* created_within_days(from, to)
* created_within_months(from, to)
* created_within_years(from, to)
* created_at_day(t)
* created_at_month(t)
* created_at_year(t)
* created_before(t)
* created_before_day(t)
* created_before_month(t)
* created_before_year(t)
* created_after(t)
* created_after_day(t)
* created_after_month(t)
* created_after_year(t)
* created_at_or_before(t)
* created_at_or_before_day(t)
* created_at_or_before_month(t)
* created_at_or_before_year(t)
* created_at_or_after(t)
* created_at_or_after_day(t)
* created_at_or_after_month(t)
* created_at_or_after_year(t)

Examples:

```ruby
# The first record created yesterday
MyModel.created_at_day(Date.yesterday).order(:created_at).first

# Records created last month
MyModel.created_at_month(Time.zone.now.last_month)

# Records created today
MyModel.created_at_day(Time.zone.now)
```

#### About the scopes' prefix

If the name of the attribute ends with `_at`, `_on`, `_time`, `_date` then `time_scope`
will drop that ending and use the rest of the name as a prefix of the scopes.
In all other cases `time_scope` use the name of the attribute as a prefix.

You can define a custom prefix for the scopes with the `verb` keyword-argument:

```ruby
# app/models/my_model.rb
class MyModel < ActiveRecord::Base
  time_scope :created_at, verb: :constructed
end

# ...
MyModel.constructed_at_or_before(7.days.ago)
```

#### About time zones

Any argument passed to the `time_scope`'s scopes are first converted to the
time-object in current time zone (with `#in_time_zone` method).
Then ActiveSupport helpers are used to derive an appropriate time range
for the query. E.g. the expression

```ruby
MyModel.created_at_day(d)  # 'd' is a date/time object
```

is identical to

```ruby
MyModel.where(
  "created_at >= ? AND created_at <= ?",
  d.in_time_zone.beginning_of_day,
  d.in_time_zone.end_of_day
)
```

### With `date` attributes

Use the `date_scope` method:

```ruby
# app/models/my_model.rb
class MyModel < ActiveRecord::Base
  date_scope :construction_date
end

```

The model has all these scopes:
* construction_within_days(from, to)
* construction_within_months(from, to)
* construction_within_years(from, to)
* construction_at_day(t)
* construction_at_month(t)
* construction_at_year(t)
* construction_before_day(t)
* construction_before_month(t)
* construction_before_year(t)
* construction_after_day(t)
* construction_after_month(t)
* construction_after_year(t)
* construction_at_or_before_day(t)
* construction_at_or_before_month(t)
* construction_at_or_before_year(t)
* construction_at_or_after_day(t)
* construction_at_or_after_month(t)
* construction_at_or_after_year(t)

Examples:

```ruby
# Records constructed earlier than on this month
MyModel.construction_before_month(Time.zone.now)
```

#### Why `date_scope` instead of `time_scope`?

Any argument passed to the `date_scope`'s scopes are first converted
to the time-object in current time zone (with `#in_time_zone` method)
and then to the date-object (with `#to_date`).
It ensures that all arguments are converted to the date representation
before passing them to database.

## TODO

* More specs.
* `*_scope` with `verb: false` to omit the scopes' prefix.
* Setup a coverage report with CodeClimate.

## Contributing

Feel free to contribute!

## License

Distributed under the MIT License (see LICENSE.txt).

Copyright (c) 2015 Daisuke Taniwaki, Alexey Chernenkov
