# Date/time scopes for ActiveRecord models

[![Gem Version](https://badge.fury.io/rb/datetime-scopes.svg)](https://badge.fury.io/rb/datetime-scopes)
[![Build Status](https://travis-ci.org/907th/datetime-scopes.svg?branch=master)](https://travis-ci.org/907th/datetime-scopes)
[![Code Climate](https://codeclimate.com/github/907th/datetime-scopes/badges/gpa.svg)](https://codeclimate.com/github/907th/datetime-scopes)
[![Test Coverage](https://codeclimate.com/github/907th/datetime-scopes/badges/coverage.svg)](https://codeclimate.com/github/907th/datetime-scopes/coverage)

Date/time scopes for ActiveRecord models you always missed! With proper time-zones support.

## Quick start

```ruby
# Gemfile
gem "datetime-scopes"
```

```ruby
# app/models/my_model.rb
class MyModel < ActiveRecord::Base
  datetime_scopes :created_at  # with 'datetime' typed attribute
  date_scopes :birthday        # with 'date' typed attribute
end
```

Now your model has these scopes:

<table>
  <tr>
    <td>
      for <b>created_at</b>
    </td>
    <td>
      for <b>birthday</b>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <ul>
        <li>created_within(from, to)</li>
        <li>created_within_days(from, to)</li>
        <li>created_within_months(from, to)</li>
        <li>created_within_years(from, to)</li>
        <li>created_on_day(t)</li>
        <li>created_on_month(t)</li>
        <li>created_on_year(t)</li>
        <li>created_before(t)</li>
        <li>created_before_day(t)</li>
        <li>created_before_month(t)</li>
        <li>created_before_year(t)</li>
        <li>created_after(t)</li>
        <li>created_after_day(t)</li>
        <li>created_after_month(t)</li>
        <li>created_after_year(t)</li>
        <li>created_on_or_before(t)</li>
        <li>created_on_or_before_day(t)</li>
        <li>created_on_or_before_month(t)</li>
        <li>created_on_or_before_year(t)</li>
        <li>created_on_or_after(t)</li>
        <li>created_on_or_after_day(t)</li>
        <li>created_on_or_after_month(t)</li>
        <li>created_on_or_after_year(t)</li>
      </ul>
    </td>
    <td valign="top">
      <ul>
        <li>birthday_within_days(from, to)</li>
        <li>birthday_within_months(from, to)</li>
        <li>birthday_within_years(from, to)</li>
        <li>birthday_on_day(t)</li>
        <li>birthday_on_month(t)</li>
        <li>birthday_on_year(t)</li>
        <li>birthday_before_day(t)</li>
        <li>birthday_before_month(t)</li>
        <li>birthday_before_year(t)</li>
        <li>birthday_after_day(t)</li>
        <li>birthday_after_month(t)</li>
        <li>birthday_after_year(t)</li>
        <li>birthday_on_or_before_day(t)</li>
        <li>birthday_on_or_before_month(t)</li>
        <li>birthday_on_or_before_year(t)</li>
        <li>birthday_on_or_after_day(t)</li>
        <li>birthday_on_or_after_month(t)</li>
        <li>birthday_on_or_after_year(t)</li>
      </ul>
    </td>
  </tr>
</table>

Examples:

```ruby
# All records created yesterday (in current `::Time.zone`)
MyModel.created_on_day(Date.yesterday)

# Records created since 11 Sep 2001 (in current `::Time.zone`)
MyModel.created_on_or_after("2001.09.11")

# Records create since 11 Sep 2001 (in New York). Yes, the result may differ to previous example!
MyModel.created_on_or_after("2001.09.11", time_zone: "Eastern Time (US & Canada)")

# Records with birthday in 2015
MyModel.birthday_on_year(Date.new 2015)
```

## Time-zone support

You know, when it is Sunday in San Francisco, it is Monday in Manila!
All parameters passed to a date/time scopes are first converted to a
project-specific (`::Time.zone`) or specified (`time_zone: "XXX"` param) time-zone with the help
of magic ActiveSupport's `#in_time_zone` helper. See `rake time:zones:all` for
all supported time-zones.

## Additional options

You can pass a default time-zone and custom scopes' prefix to a `date(time)_scopes` method:

```ruby
# app/models/my_model.rb
class MyModel < ActiveRecord::Base
  datetime_scopes :created_at, prefix: "issued", time_zone: "Ekaterinburg"
end

# All records created yesterday (in Ekaterinburg)
MyModel.issued_on_day(Date.yesterday)
```

## TODO

- Complete pending tests!
- ...

## Contributing

Any feedback is welcome!

## License

Distributed under the MIT License (see LICENSE.txt).

Copyright &copy; 2015. Alexey Chernenkov
