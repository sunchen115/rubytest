class Roman
=begin

    "M" => 1000, "CM" => 900, "D" => 500, "CD" => 400, "C" => 100,
"XC" => 90, "L" => 50, "XL" => 40, "X" => 10,
"IX" => 9, "V" => 5, "IV" => 4, "I" => 1
=end
  def self.encode(number)
    relation_map = {"M" => 1000, "CM" => 900, "D" => 500, "CD" => 400, "C" => 100,
                    "XC" => 90, "L" => 50, "XL" => 40, "X" => 10,
                    "IX" => 9, "V" => 5, "IV" => 4, "I" => 1}.invert
    res_str = ''

    relation_map.each do |key, value|
      if number >= key
        res_str += value*(number/key)
        number = number % key
      end

    end
    res_str
  end


end
