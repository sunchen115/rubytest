require 'rspec'
require_relative "../src/slit_arr"

describe 'Average split array' do

  it 'should average split arr when number less than arr.size' do

    expect(split_array((1..10).to_a,3)).to eq([[1,4,7,10],[2,5,8],[3,6,9]])
  end

  it 'should average split arr when number more than arr.size' do

    expect(split_array((1..10).to_a,20)).to eq([[1], [2], [3], [4], [5], [6], [7], [8], [9], [10]])
  end
end