require_relative '../models/user'
require_relative '../models/user_valid'
require 'sinatra/base'
require 'haml'
class MyLoginController < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/../views'
  get '/login' do
    errors = session ? session.fetch('errors', nil) : ''
    session.clear
    haml :login, :locals => {'errors' => errors}
    #Stream.new
  end

  post '/login' do
    @userinfo = UserInfo.new(params)
    if UserValid.new.valid?(@userinfo.name, @userinfo.password)
      session['login_user'] = @userinfo
      redirect '/welcome'
    else
      session['errors'] = 'password or username illegal'
      redirect '/login'
      #halt "Access denied, please <a href='/login'>login</a>."
    end
  end
end