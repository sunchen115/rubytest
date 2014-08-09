class Person
include Comparable
  attr_reader :name
  def initialize(p_name)
    @name = p_name
  end

  def <=>(another_person)
    @name<=>another_person.name
  end

  def to_s
    @name
  end

  def inspect
    @name
  end

end
