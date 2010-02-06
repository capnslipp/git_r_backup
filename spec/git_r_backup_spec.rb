require 'rubygems'
require 'spec'

require "git_r_backup"


describe GitRBackup do
    
    
  def std_args
    {
      :base => '.',
      :cache => 'tmp/backup_cache'
    }
  end
  
  def db_args
    {
      :base => '.',
      :cache => 'tmp/backup_cache',
      :app => '.'
    }
  end
  
  def assets_args
    {
      :base => '.',
      :cache => 'tmp/backup_cache',
      :assets => 'public/asserts'
    }
  end
  
  
  describe "correctly required options" do
    
    it "should complain on no args" do
      lambda {
        GitRBackup.new({})
      }.should raise_error
    end
    
    it "should not complain with standard args" do
      lambda {
        GitRBackup.new(std_args)
      }.should_not raise_error
    end
    
    it "should complain on missing :base arg" do
      lambda {
        GitRBackup.new(std_args.except(:base))
      }.should raise_error
    end
    
    it "should complain on missing :cache arg" do
      lambda {
        GitRBackup.new(std_args.except(:cache))
      }.should raise_error
    end
    
  end
  
  
  describe "correct instance variables" do
    
    it "backup_cache_repo_dir" do
      grb = GitRBackup.new(std_args)
    end
    
    it "backup_cache_sub_dir" do
      grb = GitRBackup.new(std_args)
    end
    
    it "app_dir" do
      grb = GitRBackup.new(std_args)
    end
    
    it "app_assets_dir" do
      grb = GitRBackup.new(std_args)
    end
    
    it "app_db_dump_path" do
      grb = GitRBackup.new(std_args)
    end
    
  end
  
  
end
