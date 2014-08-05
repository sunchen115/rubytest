def split_array(arr,number)
  number=arr.size if arr.size < number
  res=[]
  number.times {res<<[]}
  index=0
  arr.each { |ele| res[index%number]<<ele; index+=1}
  res
end




