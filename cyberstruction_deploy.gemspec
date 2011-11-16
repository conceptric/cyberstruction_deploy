Gem::Specification.new do |s|
  s.name = %q{cyberstruction_deploy}
  s.version = "0.2.1"
  s.date = %q{2012-11-16}
  s.authors = ["James Whinfrey"]
  s.email = %q{james@conceptric.co.uk}
  s.summary = %q{cyberstruction_deploy is a set of capistrano tasks for basic deployment to a cyberstruction server}  
  s.description = %q{The Capistrano tasks in this gem provide the deployment and management support I commonly require for my own server. You are welcome to fork this Gem and use it for your own purposes.}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.require_paths = ["lib"]
  s.files = [
    "lib/cyberstruction_deploy.rb",
    "lib/recipes/base.rb",
    "lib/recipes/variables.rb",
    "lib/recipes/apache.rb",
    "lib/recipes/mysql.rb"
  ]
  s.test_files = [
  ]
  s.add_dependency "capistrano"
  s.add_dependency "capistrano-ext"
end
