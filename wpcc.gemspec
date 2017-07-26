$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'wpcc/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'wpcc'
  s.version     = Wpcc::Version::STRING
  s.authors     = ['Money Advice Service']
  s.email       = ['development.team@moneyadviceservice.org.uk']
  s.homepage    = 'https://www.moneyadviceservice.org.uk'
  s.summary     = 'Workplace Pensions Cost Calculator'
  s.description = 'Workplace Pensions Cost Calculator'
  s.license     = 'MIT'

  s.files = Dir['{app,data,config,lib,vendor}/**/*'] +
            ['Rakefile', 'README.md', 'bower.json.erb'] -
            Dir['vendor/assets/bower_components/**/*']

  s.test_files = Dir['spec/**/*']

  s.add_dependency 'dough-ruby', '~> 5.25'

  s.add_runtime_dependency 'rails', '>= 4', '< 5'
end
