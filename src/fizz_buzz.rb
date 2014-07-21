def fizz_buzz(num)
  res = ''
  res << 'fizz' if num % 3==0
  res << 'buzz' if num % 5 ==0
  res
end
