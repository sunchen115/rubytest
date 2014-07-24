# class Fixnum
#   def palindrome_below(base)
#
#     #(1...self).select{|x|  x.to_s(base)==x.to_s(base).reverse }
#     (1...self).select { |x| ss = x.to_s(base); ss == ss.reverse }
#   end
# end


def scoreHand(num_list)
  alter_a = [1,11]
  alp_num_hash = {J: 10, Q: 10, K: 10, A: alter_a[0]}
  base_sum = num_list.reduce(0){|sum, item| alp_num_hash.has_key?(item.to_sym) ?
                                            sum + alp_num_hash[item.to_sym] : sum+item.to_i(10)}
  cnt_a = num_list.count('A')
  cnt_a.times { differ = alter_a[1]-alter_a[0];(base_sum < 21 && base_sum+differ <= 21 ) ? base_sum+=differ : break}

  base_sum


end










