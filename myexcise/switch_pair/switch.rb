name_list = %w(sc oy ct fj jp dj)


def fetch_random(list, random)
  index = random % list.size
  res = list.fetch(index)
  list.delete_at(index)
  res
end


pairs = []
random_index = Time.new.strftime("%W").to_i
name_list.push('null') if name_list.length.odd?
ori_list = name_list.sort
until ori_list.empty?
  person = ori_list.shift
  pair_person= fetch_random(ori_list, random_index)
  pairs<< [person, pair_person]
end

p pairs
