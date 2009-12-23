require "test/unit"
require "git_r_backup"

class TestGitRBackup < Test::Unit::TestCase
  
  def test_subdir_name
    grb = GitRBackup.new
    
    assert_equal nil, grb.send(:subdir_name)
    assert_equal nil, grb.send(:subdir_name, {})
    
    assert_equal 'snaotn',                        grb.send(:subdir_name, :server => 'SNAOTN')
    assert_equal 'snaotn.production',             grb.send(:subdir_name, :server => 'SNAOTN', :environment => 'production')
    assert_equal 'snaotn.clutterapp',             grb.send(:subdir_name, :server => 'SNAOTN', :app => 'ClutterApp')
    assert_equal 'snaotn.clutterapp.production',  grb.send(:subdir_name, :server => 'SNAOTN', :app => 'ClutterApp', :environment => 'production')
    assert_equal 'tsb.development',               grb.send(:subdir_name, :server => 'TSB', :environment => 'development')
    assert_equal 'test',                          grb.send(:subdir_name, :environment => 'test')
  end
  
  
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
