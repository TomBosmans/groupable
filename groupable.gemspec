$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'groupable/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'groupable'
  s.version     = Groupable::VERSION
  s.authors     = ['TomBosmans']
  s.email       = ['tom.94.bosse@gmail.com']
  s.homepage    = 'https://github.com/TomBosmans/groupable'
  s.summary     = 'One group to group them all'
  s.description = 'This gem is logic extracted from my Magnus project.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.2.0.rc1'

  s.add_development_dependency 'sqlite3'
end
