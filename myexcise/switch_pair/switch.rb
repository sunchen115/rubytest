name_list = %w(sunchen ouyang caitong fengjia jp dujuan)


def fetch_random(list)
  random_index = Time.new.strftime("%W").to_i
  index = random_index % list.size
  res = list.fetch(index)
  list.delete_at(index)
  res
end


pairs = []
name_list.push('null') if name_list.length.odd?
ori_list = name_list.sort
until ori_list.empty?
  pairs<<[ori_list.shift, fetch_random(ori_list)]
end

p pairs
