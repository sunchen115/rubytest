require 'rspec'
require_relative '../src/fizz_buzz'

describe 'FizzBuzz' do

  it 'should return fizz when diviedable 3' do

    fizz_buzz(6).should =='fizz'
  end


  it 'should return buzz when dividable 5' do

    fizz_buzz(10).should == 'buzz'
  end


  it 'should return buzz when dividable 15' do

    fizz_buzz(15).should == 'fizzbuzz'
  end

  it 'should return empty when cat not divid by 3 and 5' do

    fizz_buzz(4).should == ''
  end


end