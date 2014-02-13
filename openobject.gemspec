## openobject.gemspec
#

Gem::Specification::new do |spec|
  spec.name = "openobject"
  spec.version = "1.0.0"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "openobject"
  spec.description = "a simple property based container that's much more capable than a blankslate   but far less polluted than ruby's built-in OpenStruct"

  spec.files = ["install.rb", "lib", "lib/openobject.rb", "openobject.gemspec", "Rakefile", "README", "README.erb", "sample", "sample/a.rb", "sample/b.rb", "sample/c.rb", "sample/d.rb", "sample/e.rb", "sample/f.rb"]
  spec.executables = []
  
  spec.require_path = "lib"

  spec.has_rdoc = true
  spec.test_files = nil
  #spec.add_dependency 'lib', '>= version'
  spec.add_dependency 'fattr'

  spec.extensions.push(*[])

  spec.rubyforge_project = "codeforpeople"
  spec.author = "Ara T. Howard"
  spec.email = "ara.t.howard@gmail.com"
  spec.homepage = "http://github.com/ahoward/openobject/tree/master"
end
