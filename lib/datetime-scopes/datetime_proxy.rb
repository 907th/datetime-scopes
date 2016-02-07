require_relative "abstract_proxy"

module DateTimeScopes
  class DateTimeProxy < AbstractProxy
    PROXY_METHODS = %w[
      within
      within_days
      within_months
      within_years
      on_day
      on_month
      on_year
      before
      before_day
      before_month
      before_year
      after
      after_day
      after_month
      after_year
      on_or_before
      on_or_before_day
      on_or_before_month
      on_or_before_year
      on_or_after
      on_or_after_day
      on_or_after_month
      on_or_after_year
    ].freeze

    def proxy_methods
      PROXY_METHODS
    end

    # Intervals

    def within(rel, from, to, time_zone: @time_zone)
      rel.where(
        "#{@attribute} >= ? AND #{@attribute} <= ?",
        from.in_time_zone(time_zone),
        to.in_time_zone(time_zone)
      )
    end

    def within_days(rel, from, to, time_zone: @time_zone)
      within(
        rel,
        from.in_time_zone(time_zone).beginning_of_day,
        to.in_time_zone(time_zone).end_of_day,
        time_zone: time_zone
      )
    end

    def within_months(rel, from, to, time_zone: @time_zone)
      within(
        rel,
        from.in_time_zone(time_zone).beginning_of_month,
        to.in_time_zone(time_zone).end_of_month,
        time_zone: time_zone
      )
    end

    def within_years(rel, from, to, time_zone: @time_zone)
      within(
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

    def before(rel, time, time_zone: @time_zone)
      rel.where "#{@attribute} < ?", time.in_time_zone(time_zone)
    end

    def before_day(rel, day, time_zone: @time_zone)
      before rel, day.in_time_zone(time_zone).beginning_of_day, time_zone: time_zone
    end

    def before_month(rel, month, time_zone: @time_zone)
      before rel, month.in_time_zone(time_zone).beginning_of_month, time_zone: time_zone
    end

    def before_year(rel, year, time_zone: @time_zone)
      before rel, year.in_time_zone(time_zone).beginning_of_year, time_zone: time_zone
    end

    def after(rel, time, time_zone: @time_zone)
      rel.where "#{@attribute} > ?", time.in_time_zone(time_zone)
    end

    def after_day(rel, day, time_zone: @time_zone)
      after rel, day.in_time_zone(time_zone).end_of_day, time_zone: time_zone
    end

    def after_month(rel, month, time_zone: @time_zone)
      after rel, month.in_time_zone(time_zone).end_of_month, time_zone: time_zone
    end

    def after_year(rel, year, time_zone: @time_zone)
      after rel, year.in_time_zone(time_zone).end_of_year, time_zone: time_zone
    end

    # Non-strict equations

    def on_or_before(rel, time, time_zone: @time_zone)
      rel.where "#{@attribute} <= ?", time.in_time_zone(time_zone)
    end

    def on_or_before_day(rel, day, time_zone: @time_zone)
      on_or_before rel, day.in_time_zone(time_zone).end_of_day, time_zone: time_zone
    end

    def on_or_before_month(rel, month, time_zone: @time_zone)
      on_or_before rel, month.in_time_zone(time_zone).end_of_month, time_zone: time_zone
    end

    def on_or_before_year(rel, year, time_zone: @time_zone)
      on_or_before rel, year.in_time_zone(time_zone).end_of_year, time_zone: time_zone
    end

    def on_or_after(rel, time, time_zone: @time_zone)
      rel.where "#{@attribute} >= ?", time.in_time_zone(time_zone)
    end

    def on_or_after_day(rel, day, time_zone: @time_zone)
      on_or_after rel, day.in_time_zone(time_zone).beginning_of_day, time_zone: time_zone
    end

    def on_or_after_month(rel, month, time_zone: @time_zone)
      on_or_after rel, month.in_time_zone(time_zone).beginning_of_month, time_zone: time_zone
    end

    def on_or_after_year(rel, year, time_zone: @time_zone)
      on_or_after rel, year.in_time_zone(time_zone).beginning_of_year, time_zone: time_zone
    end
  end
end
