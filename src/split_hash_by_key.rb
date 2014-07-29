class SplitError < RuntimeError

end



def split_hash_by_key(split_hash, *split_keys)
  if split_keys.size == 1  and  not (split_hash.has_key? split_keys[0])
    raise SplitError.new("hash does not has key #{split_keys[0]}")
  end
  split_hash.reduce([{}]) {  |new_arr, item|
    new_arr<<{} if split_keys.include? item[0];
    new_arr[-1].merge!(Hash[[item]]);
    new_arr;
  }.reject {|item| item.size == 0}

end


