$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "drg_resources_plugin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "drg_resources_plugin"
  s.version     = DrgResourcesPlugin::VERSION
  s.authors     = ["Damjan Rems"]
  s.email       = ["damjan.rems@gmail.com"]
  s.homepage    = "https://www.drgcms.org"
  s.summary     = "DRG CMS application plugin for resource reservation"
  s.description = "This is DRG CMS plugin which can be used for internal resources reservation. We are using it for keeping record of company autopark."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5"
  s.add_dependency "drg_cms"
end
