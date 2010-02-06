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
    trail_slash(ENV['BASE'] || `pwd` + '/')
  end
  
  def cache_dir
    raise "CACHE='…' is required" unless ENV['CACHE'].present?
    trail_slash(ENV['CACHE'])
  end
  
  def sub_dir
    trail_slash(ENV['SUB'])
  end
  
  def app_dir
    trail_slash(ENV['APP'] || '.')
  end
  
  def assets_dir
    raise "ASSETS='…' is required" unless ENV['ASSETS'].present?
    trail_slash(ENV['ASSETS'])
  end
  
  def trail_slash(dir)
    return dir if dir[-1, 1] == '/'
    return "#{dir}/"
  end
end
