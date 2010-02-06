namespace :git_r_backup do
  desc "Back up the database as a YAML file."
  task :db => :environment do
    git_r_backup = GitRBackup.new(
      :base => base_dir,
      :cache => cache_dir,
      :sub => sub_dir,
      :app => app_dir
    )
  end
  
  desc "Back up an assets directory."
  task :assets => :environment do
    git_r_backup = GitRBackup.new(
      :base => base_dir,
      :cache => cache_dir,
      :sub => sub_dir,
      :assets => assets_dir
    )
  end
  
  desc "Back up the database and assets."
  task :all => :environment do
    git_r_backup = GitRBackup.new(
      :base => base_dir,
      :cache => cache_dir,
      :sub => sub_dir,
      :app => app_dir,
      :assets => assets_dir
    )
  end
  
  
  
  def base_dir
    ENV['BASE'] || Dir.pwd
  end
  
  def cache_dir
    raise "CACHE='…' is required" unless ENV['CACHE'].present?
    ENV['CACHE']
  end
  
  def sub_dir
    ENV['SUB'] if ENV['SUB']
  end
  
  def app_dir
    ENV['APP'] || '.'
  end
  
  def assets_dir
    raise "ASSETS='…' is required" unless ENV['ASSETS'].present?
    ENV['ASSETS']
  end
end
