require 'rubygems'
require 'git'


class GitRBackup
  VERSION = '1.0.0'
  
  
  def initialize(options)
    raise ":base option is required" unless options[:base] && !options[:base].empty?
    raise ":cache option is required" unless options[:cache] && !options[:cache].empty?
    
    @backup_cache_repo_dir = File.join(options[:base], options[:cache])
    @backup_cache_sub_dir = File.join(@backup_cache_repo_dir, options[:sub]) if options[:sub]
    
    @app_dir = File.join(options[:base], options[:app]) if options[:app]
    @app_db_dump_path = File.join(@app_dir, 'db', 'data.yml') if @app_dir
    
    @assets_dir = File.join(options[:base], options[:assets]) if options[:assets]
  end
  
  
  def backup_db
  end
  
  
  def backup_assets
  end
  
  
protected
  
  def git_repo
    @git_repo ||= if !File.exists?(@backup_cache_repo_dir)
      Git.init File.expand_path(@backup_cache_repo_dir)
    else
      Git.open File.expand_path(@backup_cache_repo_dir)
    end
  end
  
end
