class UserValid

  def initialize(filename='./tmp_files/usr_pwd.list')
    @usr_pwd_info={}
    @filename = filename
    load
  end

  def load()
    File.open(@filename) do |file|
      file.each do |line|
        line=line.strip
        tmp =  line.split(' ',2)
        @usr_pwd_info[tmp[0]] = tmp[1]
      end
    end
  end

  def valid?(username,password)
    (@usr_pwd_info.has_key?(username) and @usr_pwd_info[username]==password) ? true : false
  end

  def getall()
    @usr_pwd_info
  end

  def add_user(username, password)
    return false if @usr_pwd_info.has_key?(username)
    w_file = File.open(@filename,'a')
    w_file.write("#{username} #{password}\n")
    w_file.close
    load
  end
end

