require "spec_helper"

RSpec.describe "datetime_scopes" do
  def self.test(method_name, params:, matching:, not_matching:)
    describe "##{method_name}" do
      let!(:method_name) { "foo_#{method_name}" }
      let!(:params) { params }
      let!(:matching) { matching }
      let!(:not_matching) { not_matching }

      before do
        (matching + not_matching).each do |t|
          FooBar.create! foo: t.in_time_zone
        end
      end

      def perform
        FooBar.send method_name, *params
      end

      it "includes matching times" do
        ret = perform.to_a.map(&:foo)
        matching.map(&:in_time_zone).each do |t|
          expect(ret).to include(t)
        end
      end

      it "doesn't include not matching times" do
        ret = perform.to_a.map(&:foo)
        not_matching.map(&:in_time_zone).each do |t|
          expect(ret).not_to include(t)
        end
      end
    end
  end

  test(
    "within",
    params: ["11.01.2015 23:41:35", "12.01.2015 01:00:23"],
    matching: [
      "11.01.2015 23:41:35",
      "12.01.2015 00:40:01",
      "12.01.2015 01:00:23"
    ],
    not_matching: [
      "11.01.2015 23:41:34",
      "12.01.2015 01:00:24"
    ]
  )

  test(
    "within_days",
    params: ["11.01.2015 23:41:35", "12.01.2015 01:00:23"],
    matching: [
      "11.01.2015 00:00:00",
      "11.01.2015 23:55:01",
      "12.01.2015 00:00:01",
      "12.01.2015 23:59:59"
    ],
    not_matching: [
      "10.01.2014",
      "10.01.2015 23:59:59",
      "13.01.2015 00:00:00",
      "24.07.2015"
    ]
  )

  test(
    "within_months",
    params: ["11.01.2015 23:41:35", "12.03.2015 01:00:23"],
    matching: [
      "01.01.2015 00:00:00",
      "12.01.2015 23:55:01",
      "12.02.2015 12:05:21",
      "31.03.2015 23:59:59"
    ],
    not_matching: [
      "10.12.2014",
      "31.12.2014 23:59:59",
      "01.04.2015 00:00:00",
      "24.07.2015"
    ]
  )

  test(
    "within_years",
    params: ["11.01.2014 23:41:35", "12.03.2015 01:00:23"],
    matching: [
      "01.01.2014 00:00:00",
      "12.07.2014 23:55:01",
      "17.05.2015 12:05:21",
      "31.12.2015 23:59:59"
    ],
    not_matching: [
      "10.12.2012",
      "31.12.2013 23:59:59",
      "01.01.2016 00:00:00",
      "24.07.2016"
    ]
  )

  test(
    "on_day",
    params: ["11.03.2014"],
    matching: [
      "11.03.2014 00:00:00",
      "11.03.2014 13:55:01",
      "11.03.2014 23:59:59"
    ],
    not_matching: [
      "10.03.2014",
      "10.03.2014 23:59:59",
      "12.03.2014 00:00:00",
      "13.03.2014"
    ]
  )

  test(
    "on_month",
    params: ["11.03.2014"],
    matching: [
      "01.03.2014 00:00:00",
      "12.03.2014 13:55:01",
      "31.03.2014 23:59:59"
    ],
    not_matching: [
      "28.02.2014",
      "28.02.2014 23:59:59",
      "01.04.2014 00:00:00",
      "02.04.2014"
    ]
  )

  test(
    "on_year",
    params: ["11.03.2014"],
    matching: [
      "01.01.2014 00:00:00",
      "01.03.2014 13:55:01",
      "21.07.2014 13:55:01",
      "31.12.2014 23:59:59"
    ],
    not_matching: [
      "31.12.2013",
      "31.12.2013 23:59:59",
      "01.01.2015 00:00:00",
      "02.01.2015"
    ]
  )

  pending "#before"
  pending "#before_day"
  pending "#before_month"
  pending "#before_year"
  pending "#after"
  pending "#after_day"
  pending "#after_month"
  pending "#after_year"
  pending "#on_or_before"
  pending "#on_or_before_day"
  pending "#on_or_before_month"
  pending "#on_or_before_year"
  pending "#on_or_after"
  pending "#on_or_after_day"
  pending "#on_or_after_month"
  pending "#on_or_after_year"
end
