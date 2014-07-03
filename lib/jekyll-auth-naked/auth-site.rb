class JekyllAuthNaked
  class AuthSite < Sinatra::Base

    require 'json'
    require 'yaml'
    require 'openssl'

    # require ssl
    configure :production do
      require 'rack-ssl-enforcer'
      use Rack::SslEnforcer if JekyllAuthNaked.ssl?
    end

    use Rack::Session::Cookie, {
      http_only: true,
      secret:    ENV['SESSION_SECRET'] || SecureRandom.hex
    }

    set :github_options, {
      client_id:      ENV['GITHUB_CLIENT_ID'],
      client_secret:  ENV['GITHUB_CLIENT_SECRET'],
      scopes:         'user'
    }

    register Sinatra::Auth::Github

    before %r{^(?!/hook$)} do
      pass if JekyllAuthNaked.whitelist && JekyllAuthNaked.whitelist.match(request.path_info)
      if ENV['GITHUB_TEAM_ID']
        github_team_authenticate!(ENV['GITHUB_TEAM_ID'])
      else
        puts "ERROR: Jekyll Auth Naked is refusing to serve your site."
        puts "Looks like your oauth credentials are not properly configured. RTFM."
        halt 401
      end
    end

    post '/hook' do

      secret = ENV['GITHUB_WEBHOOK_SECRET']
      key = "sha1=#{OpenSSL::HMAC.hexdigest(HMAC_DIGEST, secret, request.body)}"

      unless request.env['HTTP_X_HUB_SIGNATURE'] == key
        puts "Github webhook secret failed to match"
        halt 401
      end

      puts " Hook -------------------------------------------------------- "
      puts request.env.to_yaml

      puts " Request body ------------------------------------------------ "
      request.body.rewind
      data = JSON.parse request.body.read
      puts data.to_yaml

    end

    get '/logout' do
      logout!
      redirect '/'
    end
  end
end
