require "test/unit"
require "git_r_backup"

class TestGitRBackup < Test::Unit::TestCase
  
  def test_filenameize
    grb = GitRBackup.new
    
    assert_equal 'test', grb.send(:filenameize, 'Test')
    assert_equal 'test', grb.send(:filenameize, 'TEST')
    
    assert_equal 'test-string', grb.send(:filenameize, 'Test String')
    assert_equal 'test-string', grb.send(:filenameize, 'test…string')
    assert_equal 'test-string', grb.send(:filenameize, 'test - string')
    assert_equal 'test-string', grb.send(:filenameize, 'test/string')
    assert_equal 'test-string', grb.send(:filenameize, 'test.string')
    
    assert_equal 'test_string', grb.send(:filenameize, 'test_string')
  end
  
end
