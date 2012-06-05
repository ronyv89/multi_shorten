require "httparty"
Dir[File.dirname(__FILE__) + '/multi_shorten/*.rb'].each do |file|
  require file
end