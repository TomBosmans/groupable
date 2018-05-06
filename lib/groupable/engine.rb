spec = Gem::Specification.find_by_name("groupable")
gem_root = spec.gem_dir
require "#{gem_root}/app/models/concerns/groupable"

module Groupable
  class Engine < ::Rails::Engine
  end
end
