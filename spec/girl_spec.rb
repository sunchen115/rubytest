require 'rspec'
require_relative '../src/girl'

describe Girl do
  context "setter getter" do
    subject {girl = Girl.new}

  end

  it 'should set and read name' do

    subject.name = 'sc'
    expect(subject.name).equal?("sc")
  end

  it 'should only get gender' do
    expect(subject.gender).equal?("female")
    expect{subject.gender='test'}.to raise_error(NoMethodError)
  end

  it 'should only set age' do
    subject.age = 18
    expect{subject.age}.to raise_error(NoMethodError)
  end
end