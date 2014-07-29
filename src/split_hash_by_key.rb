class SplitError < RuntimeError

end



def split_hash_by_key(*param)
  arr = param.shift
  split_keys = param
  if split_keys.size == 1  and  not (arr.has_key? split_keys[0])
    raise SplitError.new("hash does not has key #{split_keys[0]}")
  end

  result_arr=[]
  temp_arr=[]
  arr.each do|key,value|
    if split_keys.include? key and not temp_arr.empty?
        result_arr<< Hash[temp_arr]
        temp_arr =[[key,value]]
    else
      temp_arr<<[key,value]
    end
  end
result_arr << Hash[temp_arr]

end



