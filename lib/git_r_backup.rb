class GitRBackup
  VERSION = '1.0.0'
  
  
  def initialize(options)
    @backup_cache_repo_dir = File.join(options[:base], options[:cache])
    @backup_cache_sub_dir = File.join(@cache_path, options[:sub])
    @app_dir = File.join(options[:base], options[:app]) if options[:app]
    @app_assets_dir = File.join(options[:base], options[:assets]) if options[:assets]
    
    @app_db_dump_path = File.join(@app_dir, 'db', 'data.yml') if @app_dir
    
    puts "backup cache repo dir:\t#{@backup_cache_repo_dir.inspect}"
    puts "backup cache sub dir:\t#{@backup_cache_sub_dir.inspect}" if @backup_cache_sub_dir
    puts "app dir:\t#{@app_dir.inspect}" if @app_dir
    puts "app assets dir:\t#{@app_assets_dir.inspect}" if @app_assets_dir
    puts "app db dump path:\t#{@app_db_dump_path.inspect}" if @app_db_dump_path
  end
  
  
protected
  
end
