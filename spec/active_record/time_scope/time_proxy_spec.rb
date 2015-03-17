require "spec_helper"

RSpec.describe ActiveRecord::TimeScope::TimeProxy do
  let(:model) { double "model" }
  subject { described_class.new model, :foo_at }

  class Example < Struct.new(:expected_sql, :expected_args, :call_args) ; end

  shared_examples "time_scope" do |scope_name, example|
    describe "##{scope_name}" do
      it "forwards a request to the model" do
        dbl = double("result")
        expect(model).to receive(:where) { |sql, *args|
          expect(sql).to eq(example.expected_sql)

          # We need an exact match between time-args (uncluding time zone info)
          # so we compare these args by ISO 8601 representation.
          expect(
            args.map { |t| t.iso8601 }
          ).to eq(
            example.expected_args.map { |t| t.iso8601 }
          )

        }.and_return(dbl)
        res = subject.send(scope_name, *example.call_args)
        expect(res).to eq(dbl)
      end
    end
  end

  include_examples "time_scope", "within", Example.new(
    "foo_at >= ? AND foo_at <= ?",
    [
      Time.parse("2014-12-05T04:50:23+03:00"),
      Time.parse("2015-01-26T08:04:12+03:00")
    ],
    [
      Time.parse("2014-12-05T04:50:23+03:00"),
      Time.parse("2015-01-26T08:04:12+03:00")
    ]
  )
end
