require 'sinatra/base'
require './models/user'
require './models/user_valid'
require 'haml'
require './controllers/my_login_controller'
require './controllers/my_regist_controller'


class MyApp <Sinatra::Base
  use MyLoginController
  use MyRegistController
  set :sessions, true
#use Rack::Session::Pool, :expire_after => 2592000
#
# class Stream
#   def each
#     100.times { |i| yield "#{i}\n" }
#   end
# end

  before do

    if request.path_info != '/login' and request.path_info != '/regist'
      request.path_info ='/login' if not session.has_key?('login_user')
    end
    #request.request_method='GET'
    #p request.class.instance_methods
  end



  get '/welcome' do
    #session.has_key?('login_user') ?  haml(:welcome,:locals=>{'login_user'=>session['login_user']}) : redirect('/')
    haml(:welcome, :locals => {'login_user' => session['login_user']})
  end





  not_found do
    redirect '/login'
  end

end

