require 'test/unit'
require 'databag_version'

class DBVTest < Test::Unit::TestCase
  def test_id
    assert_equal "derp_0_0_1",
      DatabagVersion.id("derp")
  end

  def test_process_all
    assert_nil DatabagVersion.process_all
    assert_nothing_raised{ DatabagVersion.process_all(false) }
    assert_nothing_raised{ DatabagVersion.process_all(false, "/this/path/shouldnt/exist") }
    assert_nothing_raised{ DatabagVersion.process_all(false, "/tmp") }
  end
end
