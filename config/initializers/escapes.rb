begin
  require 'escape_utils/html/rack' # to patch Rack::Utils
  require 'escape_utils/html/erb' # to patch ERB::Util
  require 'escape_utils/html/cgi' # to patch CGI
rescue LoadError
  Rails.logger.info 'Escape_utils is not in the gemfile'
end