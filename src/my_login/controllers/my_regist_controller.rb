require_relative '../models/user'
require_relative '../models/user_valid'
require 'sinatra/base'
require 'haml'
class MyRegistController < Sinatra::Base

  set :views, File.dirname(__FILE__) + '/../views'
  get '/regist' do
    regist_info=session['regist_info'] ? session['regist_info'] : UserInfo.new()

    haml :regist, :locals => {'usrinfo' => regist_info}
  end

  post '/regist' do
    regist_user = UserInfo.new(params)
    is_suc = UserValid.new.add_user(params['username'], params['pwd'])
    regist_user.errors = is_suc ? 'regist ok! you can login' : "#{params['usrname']} has been registed!"

    session['regist_info'] = regist_user
    redirect '/regist'

  end
end