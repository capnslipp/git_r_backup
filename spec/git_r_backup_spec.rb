require 'rubygems'
require 'spec'

require "git_r_backup"


describe GitRBackup do
  
  describe "correct instance variables" do
    
    it "backup_cache_repo_dir" do
      grb = GitRBackup.new({})
    end
    
    it "backup_cache_sub_dir" do
      grb = GitRBackup.new({})
    end
    
    it "app_dir" do
      grb = GitRBackup.new({})
    end
    
    it "app_assets_dir" do
      grb = GitRBackup.new({})
    end
    
    it "app_db_dump_path" do
      grb = GitRBackup.new({})
    end
    
  end
  
end
