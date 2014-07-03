require 'rubygems'
require 'sinatra-index'
require 'sinatra_auth_github'
require 'rack'
require 'dotenv'
require 'safe_yaml'
require File.dirname(__FILE__) + '/jekyll-auth-naked/version'
require File.dirname(__FILE__) + '/jekyll-auth-naked/config'
require File.dirname(__FILE__) + '/jekyll-auth-naked/auth-site'
require File.dirname(__FILE__) + '/jekyll-auth-naked/jekyll-site'
Dotenv.load

class JekyllAuthNaked
  def self.site
    Rack::Builder.new do
      use JekyllAuthNaked::AuthSite
      run JekyllAuthNaked::JekyllSite
    end
  end
end
