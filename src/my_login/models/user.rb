class UserInfo
  attr_reader :name,:password
  attr_accessor :errors
  def initialize(params=nil)
    @name = params ? params['username'] : ''
    @password = params ? params['pwd'] : ''
    @errors=''
  end

end