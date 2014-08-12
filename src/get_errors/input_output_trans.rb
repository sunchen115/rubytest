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


  def self.export(filename, errors_info,white_rules,cut_by_spot)
    @@white_rules = white_rules
    out_file = File.new(filename, 'w')
    out_file_exception = File.new(filename+".exception", 'w')
    errors_info.keys.sort_by{ |key| key.downcase}.each do |key|
      key_errors=errors_info[key]
      key_errors.uniq!
      has_write=[]
      key_errors.each do |key_error|
        if cut_by_spot && key_error.is_a?(String)
          key_error = key_error.split('.')[0]
        end
        unless has_write.include?(key_error)
          if self.is_white_rule?(key,key_error)
            out_file_exception.write("#{key}\t#{key_error}\n")
          else
            out_file.write("#{key}\t#{key_error}\n")
          end
          has_write<<key_error
        end

      end
    end
    out_file.close
    out_file_exception.close
  end
  private
  def self.is_white_rule?(key,value)
     @@white_rules.fetch(key,[]).select { |rule| not value.match(rule).nil? }.any?


  end
end

