require 'rspec'
require_relative '../src/arr_extend'

describe 'Array extend' do
  context "group_by1" do

    it 'group by string' do
      res = ['peter', 'p2', 'p4', 't1', 't2'].group_by1 { |ele| ele[0] }
      expect(res).to eq({'p' => ["peter", "p2", "p4"], 't' => ["t1", "t2"]})
    end

    it 'group by boolean' do
      res = ['peter', 'p2', 'p4', 't1', 't2'].group_by1 { |ele| ele[0]=='p' }
      expect(res).to eq({true => ["peter", "p2", "p4"], false => ["t1", "t2"]})
    end
  end

  context 'inject1' do
    it 'should sum the elements' do
      sum_val = [1,2,3,4,5].inject1(0) {|res,ele| res+ele}
      expect(sum_val).to be(15)
    end

    it 'should inject to a map' do
      sum_val = [1,2,3,4,5].inject1({}) {|res,ele| res[ele]=ele ; res}
      expect(sum_val).to eq({1=>1, 2=>2, 3=>3, 4=>4, 5=>5})
    end


  end
end