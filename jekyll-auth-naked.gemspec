require './lib/jekyll-auth-naked/version'

Gem::Specification.new do |s|
  s.name                  = "jekyll-auth-naked"
  s.version               = JekyllAuthNaked::VERSION
  s.summary               = "A simple way to self-host a Github OAuth protected jekyll site to your GitHub Team."
  s.description           = <<-EOD
                            A simple way to self-host a Github OAuth protected jekyll site to your
                            GitHub Team. Forked from Jekyll-Auth, without the Heroku dependency, add
                            github webhook support, and intended for a self-hosted environment.
  EOD
  s.authors               = "Jason Milkins"
  s.email                 = "jasonm23@gmail.com"
  s.homepage              = "https://github.com/jasonm23/jekyll-auth-naked"
  s.license               = "MIT"
  s.files                 = ["lib/jekyll-auth-naked.rb", "bin/jekyll-auth-naked", "config.ru", "Rakefile",
                             "lib/jekyll-auth-naked/auth-site.rb", "lib/jekyll-auth-naked/jekyll-site.rb",
                             "lib/jekyll-auth-naked/version.rb", "lib/jekyll-auth-naked/config.rb", ".gitignore"]
  s.executables           = ["jekyll-auth-naked"]
  s.add_dependency("jekyll", "~> 2.0")
  s.add_dependency("sinatra-index", "~> 0.0")
  s.add_dependency("sinatra_auth_github", "~> 1.0")
  s.add_dependency("commander", "~> 4.1")
  s.add_dependency("git", "~> 1.2")
  s.add_dependency("dotenv", "~> 0.11")
  s.add_dependency("rake", "~> 10.3")
  s.add_dependency("rack-ssl-enforcer", "~> 0.2")
  s.add_runtime_dependency('safe_yaml', "~> 1.0")
end
