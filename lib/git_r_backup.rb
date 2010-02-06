require 'iconv'


class GitRBackup
  VERSION = '1.0.0'
  
  PARTS = [:server, :instance, :environment]
  
  
  def initialize(options)
  end
  
  
  def backup(app_path, backup_repo_path, options = {})
    decide_paths(app_path, backup_repo_path, options)
  end
  
  
protected
  
  def decide_paths(app_path, backup_repo_path, options)
    if backup_subdir = subdir_name(options)
      @backup_path = File.join(backup_repo_path, backup_subdir)
    else
      @backup_path = backup_repos_path
    end
    @backup_cache_repo_dir = File.join(options[:base], options[:cache])
    @backup_cache_sub_dir = File.join(@cache_path, options[:sub])
    @app_dir = File.join(options[:base], options[:app]) if options[:app]
    @app_assets_dir = File.join(options[:base], options[:assets]) if options[:assets]
    
    @ap_db_dump_path = File.join(@app_dir, 'db', 'data.yml') if @app_dir
    
    puts "backup cache repo dir:\t#{@backup_cache_repo_dir.inspect}"
    puts "backup cache sub dir:\t#{@backup_cache_sub_dir.inspect}" if @backup_cache_sub_dir
    puts "app dir:\t#{@app_dir.inspect}" if @app_dir
    puts "app assets dir:\t#{@app_assets_dir.inspect}" if @app_assets_dir
    puts "app db dump path:\t#{@ap_db_dump_path.inspect}" if @ap_db_dump_path
  end
  
  
  def subdir_name(options)
    subdir_parts = []
    
    PARTS.each do |p_opt|
      subdir_parts << filenameize(options[p_opt]) if options[p_opt]
    end
    
    return nil if subdir_parts.empty?
    
    subdir_parts.join('.')
  end
  
  
  # stolen and modified from ActiveSupport::Inflector
  def filenameize(string)
      # replace accented chars with ther ascii equivalents
      string = Iconv.iconv('ascii//ignore//translit', 'utf-8', string).to_s
      
      # Turn unwanted chars into the seperator
      string.gsub!(/[^a-z0-9\-_]+/i, '-')
      
      re_sep = Regexp.escape('-')
      # No more than one of the separator in a row.
      string.gsub!(/#{re_sep}{2,}/, '-')
      # Remove leading/trailing separator.
      string.gsub!(/^#{re_sep}|#{re_sep}$/i, '')
      
      string.downcase
  end
  
end
