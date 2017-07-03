require 'site_prism'

require_relative 'page'

%w(your_details your_contributions).each do |dir_name|
  Dir[File.dirname(__FILE__) + "/#{dir_name}/*.rb"].each do |file_name|
    require file_name
  end
end
