require 'iconv'


class GitRBackup
  VERSION = '1.0.0'
  
  PARTS = [:server, :app, :environment]
  
  
protected
  
  def subdir_name(options = {})
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
