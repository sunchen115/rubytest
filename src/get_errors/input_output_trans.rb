require 'json'
class InputTrans

  def self.trans(filename="./sample_errors_json")
    index= 0
    total_line = ""
    File.open(filename) do |file|
      while line = file.gets
        index+=1
        line = line.strip
        total_line<<line
      end
    end
     JSON.parse total_line
  end
end

class OutputTrans


  def self.export(filename, errors_info)
    out_file = File.new(filename, 'w')
    errors_info.each do |key, key_errors|
      key_errors.each { |key_error| out_file.write("#{key}\t#{key_error}\n") }
    end
    out_file.close
  end
end

