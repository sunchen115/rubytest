class Girl

  def self.my_attr_reader param

    define_method param do
      self.instance_variable_get("@#{param}")
    end
  end

  def self.my_attr_accessor param
    self.my_attr_writer param
    self.my_attr_reader param
  end

  def self.my_attr_writer param
    define_method "#{param}=" do |val|
      self.instance_variable_set("@#{param}",val)
    end

  end

  my_attr_accessor :name
  my_attr_reader :gender
  my_attr_writer :age

  def initialize
    @gender = 'female'
  end
end
