require_relative "./input_output_trans"


class ErrorsExtractor
  attr_reader :intput_filename, :errors_info

  def initialize(fn = './sample_errors_json')
    @input_filename = fn

    @errors_info = {}
  end

  def json_2_hash(str_json)
    JSON.parse str_json
  end

  def record_errors info
    info.fetch('errors', {}).each do |key, value|
      @errors_info[key]=[] unless @errors_info.has_key?(key)
      value = [value] if value.is_a?(String)
      @errors_info[key].concat(value)
    end

  end
  def unescape( src )

    String.class_eval(%Q("#{src}"))

  end
  def _extract_err(raw_info)
    log_level = raw_info[0, 10]
    if log_level.include?('err')
       begin

        error_info =  raw_info.scan(/response:\s*(.*)\"/)[0][0]
         error_info = error_info[1,error_info.size-1]
        error_info = error_info.gsub(/\\\"/, '"').gsub(/\\\"/, '"')

         error_hash_single = json_2_hash error_info
         record_errors error_hash_single
        return 0
      rescue => e
        #p e
        #p raw_info
        return 2
       end
    else
      return 1#not include err
    end

  end
  # def _extract_err(raw_info)
  #   log_level = raw_info[0, 10]
  #   if log_level.include?('err')
  #     begin
  #       error_info = raw_info.scan(/RuntimeError:.*?response: \"(.*)?,\\\"parse_info/)[0][0]
  #       #p error_info
  #       error_hash_single = json_2_hash error_info.gsub(/\\/, '')+"}"
  #       record_errors error_hash_single
  #     rescue => e
  #       p e
  #       p raw_info
  #     end
  #   end
  # end

  def get_errors

    line_arr = InputTrans.trans(@input_filename)
    line_arr.each do |line|
      raw_info = line['_raw']
      _extract_err(raw_info)
    end
    @errors_info.each { |key, value| value.uniq! }
    export_to_file
  end

  def show_extract_info(status_info)
    map_info = {0=>'suc',1=>'not include[err]',2=>'parse fail'}
    print map_info.map {|key,value| "#{value}[#{status_info[key]}]"}.join(",")
  end
  def extract_from_txt
    status_code_info = [0,0,0]
    File.open(@input_filename) do |file|
      while line = file.gets
        line = line.strip
        status_code = _extract_err(line)
        status_code_info[status_code]+=1
      end
    end
    @errors_info.each { |key, value| value.uniq! }
    export_to_file
    show_extract_info(status_code_info)
  end

  def export_to_file(out_f = './output.txt')
    OutputTrans.export(out_f, @errors_info)
  end
end

# ErrorsExtractor.new("./sample_errors_json").get_errors
#ErrorsExtractor.new("./rex-consumer-24hours.json").get_errors
#ErrorsExtractor.new("./exception_errs.txt").test_exception
ErrorsExtractor.new("./rex-consumer-24hours.txt").extract_from_txt
