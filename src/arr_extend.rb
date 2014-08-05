class Array
  def group_by1
    res = {}
    self.each{|ele| key = yield ele; res.has_key?(key) ? res[key]<<ele : res[key]=[ele]}
    res
  end

  def inject1(ini_val)
    res_val = ini_val
    self.each{|ele|   res_val = yield res_val,ele }
    res_val
  end
end
