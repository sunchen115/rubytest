require_relative "../show/model/residential"

def fatal str
  puts "   \033[31m#{str}\033[0m\n"
end

def hilight str
  puts  "   \033[33m#{str}\033[0m\n"
end

def green str
  puts "   \033[32m#{str}\033[0m\n"
end

def info str
 puts "   \033[36m#{str}\033[0m\n"
end

class Job


  def self.run
    cnt=1
    while 1
      hilight "#{'*'*50}cnt=#{cnt}, current.list.size=#{Thread.list.size}#{'*'*50}"
      t = Thread.new {
        cnt=cnt+1
        begin
           info Residential.get_top5
        rescue => e
          fatal "#{Thread.current.object_id} excepion! "
        end
        sleep 10#thread alive in longer time
        #debug "#{'*'*50}#{Thread.current.object_id} /done"
        cnt=cnt-1
      }
      sleep 1
    end
  end
end

Job.run