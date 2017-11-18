$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "resourceable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "resourceable"
  s.version     = Resourceable::VERSION
  s.authors     = ["Jason Hazel"]
  s.email       = ["me@jasonhazel.com"]
  s.homepage    = "https://github.com/mrhazel/resourceable"
  s.summary     = "Simplify CRUD"
  s.description = "Better than scaffolds"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  # cancan 
  # simple_form 
  # kaminari

  s.add_development_dependency "sqlite3"
end
