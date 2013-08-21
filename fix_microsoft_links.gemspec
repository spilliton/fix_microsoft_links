Gem::Specification.new do |s|
  s.name        = "fix_microsoft_links"
  s.license     = 'MIT'
  s.version     = "0.1.4"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Zachary Kloepping", "Jon Bell"]
  s.homepage    = "https://github.com/spilliton/fix_microsoft_links"
  s.summary     = "Fixes redirects to login pages when a user clicks a link to your site from a Microsoft application like Word or Excel"
  s.files       = [
                  "init.rb",
                  "lib/fix_microsoft_links.rb",
                  "lib/fix_microsoft_links/railtie.rb"]
 
  s.add_dependency('rack', [">= 1.1.1"])
end