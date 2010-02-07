require 'rubygems'
require 'git'


class GitRBackup
  VERSION = '1.0.0'
  
  
  def initialize(options)
    raise ":base option is required" unless options[:base] && !options[:base].empty?
    raise ":cache option is required" unless options[:cache] && !options[:cache].empty?
    
    @backup_cache_repo_dir = File.join(options[:base], options[:cache])
    @backup_cache_sub = options[:sub]
    @backup_cache_sub_dir = File.join(@backup_cache_repo_dir, @backup_cache_sub) if @backup_cache_sub
    
    @app_dir = File.join(options[:base], options[:app]) if options[:app]
    @app_db_data_dump_path = File.join(@app_dir, 'db', 'data.yml') if @app_dir
    @app_db_schema_dump_path = File.join(@app_dir, 'db', 'schema.rb') if @app_dir
    
    @assets_dir = File.join(options[:base], options[:assets]) if options[:assets]
  end
  
  
  def backup_db
    system 'rake db:dump'
    
    full_app_db_data_dump_path = File.expand_path(@app_db_data_dump_path)
    full_app_schema_data_dump_path = File.expand_path(@app_db_schema_dump_path)
    in_dest_cache_dir do
      FileUtils.cp full_app_db_data_dump_path, './'
      FileUtils.cp full_app_schema_data_dump_path, './'
      
      system 'git add -A' # there seems to be no option to do this with Git::Base
    end
    
    date_s = Time.now.strftime '%Y-%m-%d'
    if !@backup_cache_sub
      git_repo.commit_all "automated database backup on #{date_s}"
    else
      git_repo.commit_all "automated database backup for '#{@backup_cache_sub}' on #{date_s}"
    end
    
    git_repo.push unless git_repo.remotes.empty?
  end
  
  
  def backup_assets
    full_assets_dir = File.expand_path(@assets_dir)
    in_dest_cache_dir do
      FileUtils.cp_r full_assets_dir, './'
      
      system 'git add -A' # there seems to be no option to do this with Git::Base
    end
    
    date_s = Time.now.strftime '%Y-%m-%d'
    if !@backup_cache_sub
      git_repo.commit_all "automated assets backup on #{date_s}"
    else
      git_repo.commit_all "automated assets backup for '#{@backup_cache_sub}' on #{date_s}"
    end
    
    git_repo.push unless git_repo.remotes.empty?
  end
  
  
protected
  
  def git_repo
    full_backup_cache_repo_dir = File.expand_path(@backup_cache_repo_dir)
    @git_repo ||= if !File.exists?(@backup_cache_repo_dir)
      Git.init full_backup_cache_repo_dir
    else
      Git.open full_backup_cache_repo_dir
    end
  end
  
  def in_dest_cache_dir
    FileUtils.mkdir_p(@backup_cache_sub_dir) if @backup_cache_sub_dir
    Dir.chdir(@backup_cache_sub_dir || @backup_cache_repo_dir) do
      yield
    end
  end
  
end
