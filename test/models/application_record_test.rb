require "test_helper"

class ApplicationRecordTest < ActiveSupport::TestCase
  test "uses the target Ruby and Rails versions" do
    assert_equal "4.0.5", RUBY_VERSION
    assert_equal "8.1.3", Rails.version
  end

  test "is an abstract Active Record base class" do
    assert_predicate ApplicationRecord, :abstract_class?
  end
end
