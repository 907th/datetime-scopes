require "spec_helper"

RSpec.describe DateTimeScopes::DateTimeProxy do
  subject { described_class.new klass: FooBar, attribute: "foo", time_zone: "Moscow" }

  pending "TODO"
end
