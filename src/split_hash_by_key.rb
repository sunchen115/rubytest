class SplitError < RuntimeError

end



def split_hash_by_key(*param)
  slit_hash = param.shift
  split_keys = param
  if split_keys.size == 1  and  not (slit_hash.has_key? split_keys[0])
    raise SplitError.new("hash does not has key #{split_keys[0]}")
  end
  slit_hash.reduce([{}]) {  |new_arr, item|
    new_arr<<{} if split_keys.include? item[0];
    new_arr[-1].merge!(Hash[[item]]);
    new_arr;
  }.reject {|item| item.size == 0}

end


