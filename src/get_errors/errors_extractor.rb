require 'yaml'
require_relative "./input_output_trans"


class ErrorsExtractor
  attr_reader :intput_filename, :errors_info, :cluster_rules

  def initialize(*filenames)
    @input_filename = filenames
    @cluster_rules={}
    @errors_info = {}
  end

  def json_2_hash(str_json)
    JSON.parse str_json
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

  # def get_errors
  #
  #   line_arr = InputTrans.trans(@input_filename)
  #   line_arr.each do |line|
  #     raw_info = line['_raw']
  #     _extract_err(raw_info)
  #   end
  #   @errors_info.each { |key, value| value.uniq! }
  #   export_to_file
  # end


  def extract_from_txt(out_file = './output.txt', cluster_file="./cluster_rule", cut_by_spot=false)

    @cluster_rules = _load_cluster_rules cluster_file
    status_code_info = [0, 0, 0]
    @input_filename.each do |input_file|
      if  File.exist?(input_file)

        File.open(input_file) do |file|
          while line = file.gets
            line = line.strip
            status_code = _extract_err(line)
            status_code_info[status_code]+=1
          end
        end
      end
    end
    export_to_file(out_file, cut_by_spot)
    show_extract_info(status_code_info)
  end

  def find_valid_attr(obj)
    if obj.is_a?(Hash)
      obj.each do |key, value|

        if key.include? 'invalid'
          p value
        end
        find_valid_attr(value)
      end
    end
  end

  def extract_from_yaml
    yaml_config = YAML.load(File.read(@input_filename[0]))
    find_valid_attr(yaml_config)
  end


  private

  def show_extract_info(status_info)
    map_info = {0 => 'suc', 1 => 'not include[err]', 2 => 'parse fail'}
    print map_info.map { |key, value| "#{value}[#{status_info[key]}]" }.join(",")+"\n"
  end

  def _record_errors info
    info.fetch('errors', {}).each do |key, value|
      @errors_info[key]=[] unless @errors_info.has_key?(key)
      value = [value] if value.is_a?(String)
      value.each do |val|
        ori_val = val
        val=_update_by_cluster_rule(key, val);

        @errors_info[key]<<val unless @errors_info[key].include? val
      end
    end
    #@errors_info[key].concat(value)
    #p @errors_info['suburb']
  end

  def _update_by_cluster_rule(key, value)
    return value unless @cluster_rules.has_key? key
    rule = @cluster_rules[key].select { |rule| not value.match(rule).nil? }
    rule.any? ? rule[0] : value
  end

  def export_to_file(out_f = './output.txt', cut_by_spot=false)
    OutputTrans.export(out_f, @errors_info, cut_by_spot)
  end

  def _extract_err_string(raw_info)
    log_level = raw_info[0, 10]
    if log_level.include?('err')
      begin

        error_info = raw_info.scan(/} - (.*?):(.*)/)[0]

        _record_errors 'errors' => {error_info[0] => error_info[1]}
        return 0
      rescue => e
        #p e
        puts raw_info
        return 2
      end
    else
      return 1 #not include err
    end
  end

  def _extract_err(raw_info)
    log_level = raw_info[0, 10]
    if log_level.include?('err')
      begin

        error_info = raw_info.scan(/response:\s*(.*)\"/)[0][0]
        error_info = error_info[1, error_info.size-1]
        error_info = error_info.gsub(/\\\"/, '"').gsub(/\\\"/, '"')

        error_hash_single = json_2_hash error_info
        _record_errors error_hash_single
        return 0
      rescue => e
        #p e
        return _extract_err_string(raw_info)
      end
    else
      return 1 #not include err
    end

  end

  def _load_cluster_rules rule_file
    rules_info = {}
    File.open(rule_file) do |file|
      while line=file.gets
        line=line.strip()
        if line=="" or line[0]=='#'
          next
        end
        rule_info = line.split("\t")
        key = rule_info[0]
        val = rule_info[1]
        unless rules_info.has_key?(key)
          rules_info[key]=[]
        end
        rules_info[key]<< val
      end
    end
    rules_info
  end
end

# ErrorsExtractor.new("./sample_errors_json").get_errors
#ErrorsExtractor.new("./rex-consumer-24hours.json").get_errors
#ErrorsExtractor.new("./exception_errs.txt").extract_from_txt
# ErrorsExtractor.new("./rex-consumer-24hours.txt").extract_from_txt("./comsumer_output.txt",false)
# ErrorsExtractor.new("./rex-spilter-24hours.txt").extract_from_txt("./split_output.txt",false)

#ErrorsExtractor.new("./input/rex-consumer-24hours.txt", "./input/rex-spilter-24hours.txt").extract_from_txt("./output/total_output.txt", "./input/cluster_rule", false)
ErrorsExtractor.new("./input/rex-consumer-30days.txt", "./input/rex-spliter-30days.txt").extract_from_txt("./output/30day_errs.txt", "./input/cluster_rule")

# ErrorsExtractor.new("./en-reaxml.yml").extract_from_yaml
