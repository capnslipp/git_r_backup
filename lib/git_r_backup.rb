class GitRBackup
  VERSION = '1.0.0'
  
  
  def initialize(options)
    raise ":base option is required" unless options[:base] && !options[:base].empty?
    raise ":cache option is required" unless options[:cache] && !options[:cache].empty?
    
    @backup_cache_repo_dir = File.join(options[:base], options[:cache])
    @backup_cache_sub_dir = File.join(@backup_cache_repo_dir, options[:sub]) if options[:sub]
    puts "backup cache repo dir:\t#{@backup_cache_repo_dir.inspect}"
    puts "backup cache sub dir:\t#{@backup_cache_sub_dir.inspect}" if @backup_cache_sub_dir
    
    @app_dir = File.join(options[:base], options[:app]) if options[:app]
    @app_db_dump_path = File.join(@app_dir, 'db', 'data.yml') if @app_dir
    puts "app dir:\t#{@app_dir.inspect}" if @app_dir
    puts "app db dump path:\t#{@app_db_dump_path.inspect}" if @app_db_dump_path
    
    @assets_dir = File.join(options[:base], options[:assets]) if options[:assets]
    puts "assets dir:\t#{@assets_dir.inspect}" if @assets_dir
  end
  
  
protected
  
end
