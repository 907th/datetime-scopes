require_relative "abstract_proxy"

module DateTimeScopes
  class DateProxy < AbstractProxy
    PROXY_METHODS = %w[
      within_days
      within_months
      within_years
      on_day
      on_month
      on_year
      before_day
      before_month
      before_year
      after_day
      after_month
      after_year
      on_or_before_day
      on_or_before_month
      on_or_before_year
      on_or_after_day
      on_or_after_month
      on_or_after_year
    ].freeze

    def proxy_methods
      PROXY_METHODS
    end

    # Intervals

    def within_days(rel, from, to, time_zone: @time_zone)
      rel.where(
        "#{@attribute}) >= ? AND #{@attribute} <= ?",
        from.in_time_zone(time_zone).to_date,
        to.in_time_zone(time_zone).to_date
      )
    end

    def within_months(rel, from, to, time_zone: @time_zone)
      within_days(
        rel,
        from.in_time_zone(time_zone).beginning_of_month,
        to.in_time_zone(time_zone).end_of_month,
        time_zone: time_zone
      )
    end

    def within_years(rel, from, to, time_zone: @time_zone)
      within_days(
        rel,
        from.in_time_zone(time_zone).beginning_of_year,
        to.in_time_zone(time_zone).end_of_year,
        time_zone: time_zone
      )
    end

    # Specific day/month/year

    def on_day(rel, day, time_zone: @time_zone)
      within_days rel, day, day, time_zone: time_zone
    end

    def on_month(rel, month, time_zone: @time_zone)
      within_months rel, month, month, time_zone: time_zone
    end

    def on_year(rel, year, time_zone: @time_zone)
      within_years rel, year, year, time_zone: time_zone
    end

    # Strict equations

    def before_day(rel, day, time_zone: @time_zone)
      rel.where "#{@attribute} < ?", day.in_time_zone(time_zone).to_date
    end

    def before_month(rel, month, time_zone: @time_zone)
      before_day rel, month.in_time_zone(time_zone).beginning_of_month, time_zone: time_zone
    end

    def before_year(rel, year, time_zone: @time_zone)
      before_day rel, year.in_time_zone(time_zone).beginning_of_year, time_zone: time_zone
    end

    def after_day(rel, day, time_zone: @time_zone)
      rel.where "#{@attribute} > ?", day.in_time_zone(time_zone).to_date
    end

    def after_month(rel, month, time_zone: @time_zone)
      after_day rel, month.in_time_zone(time_zone).end_of_month, time_zone: time_zone
    end

    def after_year(rel, year, time_zone: @time_zone)
      after_day rel, year.in_time_zone(time_zone).end_of_year, time_zone: time_zone
    end

    # Non-strict equations

    def on_or_before_day(rel, day, time_zone: @time_zone)
      rel.where "#{@attribute} <= ?", day.in_time_zone(time_zone).to_date
    end

    def on_or_before_month(rel, month, time_zone: @time_zone)
      on_or_before_day rel, month.in_time_zone(time_zone).end_of_month, time_zone: time_zone
    end

    def on_or_before_year(rel, year, time_zone: @time_zone)
      on_or_before_day rel, year.in_time_zone(time_zone).end_of_year, time_zone: time_zone
    end

    def on_or_after_day(rel, day, time_zone: @time_zone)
      rel.where "#{@attribute} >= ?", day.in_time_zone(time_zone).to_date
    end

    def on_or_after_month(rel, month, time_zone: @time_zone)
      on_or_after_day rel, month.in_time_zone(time_zone).beginning_of_month, time_zone: time_zone
    end

    def on_or_after_year(rel, year, time_zone: @time_zone)
      on_or_after_day rel, year.in_time_zone(time_zone).beginning_of_year, time_zone: time_zone
    end
  end
end
