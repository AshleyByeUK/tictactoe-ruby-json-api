libdir = File.dirname(__FILE__) + '/lib/'
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'json_api/json_api'

run JsonAPI::JsonAPI
