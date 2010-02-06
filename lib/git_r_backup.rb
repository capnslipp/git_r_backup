require 'iconv'


class GitRBackup
  VERSION = '1.0.0'
  
  PARTS = [:server, :instance, :environment]
  
  
  def initialize(options)
    @cache_path = File.join(options[:base], options[:cache])
    @sub_dir = File.join(@cache_path, options[:sub])
    @app_path = File.join(options[:base], options[:app]) if options[:app]
    @assets_path = File.join(options[:base], options[:assets]) if options[:assets]
    
    puts "cache dir:\t#{@cache_path.inspect}"
    puts "sub dir:\t#{@sub_dir.inspect}" if @sub_dir
    puts "app path:\t#{@app_path.inspect}" if @app_path
    puts "assets path:\t#{@assets_path.inspect}" if @assets_path
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
    
    @app_data_path = File.join(app_path, 'db', 'data.yml') unless options[:skip_db]
    
    @app_asset_path = File.join([app_path] + [options[:asset_dir]]) if options[:asset_dir]
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
