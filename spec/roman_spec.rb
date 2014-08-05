require 'rspec'
require_relative "../src/roman"
describe 'Roman' do

  it 'should encode with 4' do

    expect(Roman.encode(2014)).to eq("MMXIV")
  end

  it 'should encode with 4 2' do

    expect(Roman.encode(1234)).to eq("MCCXXXIV")
  end
  it 'should encode with less than 1000' do

    expect(Roman.encode(912)).to eq("CMXII")
  end


end