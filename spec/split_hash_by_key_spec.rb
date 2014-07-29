require 'rspec'
require_relative "../src/split_hash_by_key"

describe 'split_hash_by_key' do

  it 'should be correct when keys more than one' do

    expect(split_hash_by_key({:a => 1, :b => 2, :c => 4, :d => 5, :e => 6, :f => 7}, :c, :e)).to eq([{:a => 1, :b => 2}, {:c => 4, :d => 5}, {:e => 6, :f => 7}])
    expect(split_hash_by_key({:a => 1, :b => 2, :c => 3, :d => 4, :e => 5, :f => 6}, :b, :f)).to eq([{:a => 1}, {:b => 2, :c => 3, :d => 4, :e => 5}, {:f => 6}])
    expect(split_hash_by_key({:a => 1, :b => 2, :c => 3, :d => 4, :e => 5, :f => 6}, :d)).to eq([{:a => 1, :b => 2, :c => 3}, {:d => 4, :e => 5, :f => 6}])
  end

  it 'should be correct when key is only one' do

    expect(split_hash_by_key({:a => 1, :b => 2}, :a)).to eq([{:a => 1, :b => 2}])
  end

  it 'should be correct when key is string or symbol' do

    expect(split_hash_by_key({:a => 1, :b => 2, :c=>3}, :b)).to eq([{:a => 1},{:b => 2,:c=>3}])
    expect(split_hash_by_key({:a => 1, :b => 2, :c=>3}, 'b')).to eq([{:a => 1},{:b => 2,:c=>3}])
  end

  it 'it should raise SplitError when hash does not has key ' do
    expect{split_hash_by_key({:a => 1, :b => 2}, :c)}.to raise_error(SplitError)
  end

end