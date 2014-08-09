require 'rspec'
require_relative '../src/peopel_sort'
describe Person do

  it 'should sort by name' do

    p1 = Person.new("Matz")
    p2 = Person.new("Guido")
    p3 = Person.new("Larry")
    expect([p1, p2, p3].sort.map{|person|person.to_s}).to eq(["Guido", "Larry", "Matz"])

  end
end