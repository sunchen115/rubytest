require 'rspec'

class UserInfo
  attr_reader :name, :password, :price
  attr_accessor :errors, :reader

  def initialize(params=nil)
    @name = params ? params[:name] : ''
    @password = params ? params[:pwd] : ''
    @errors=''
  end

  def compute_price(member)
    member.pri_mock
    @price = member.price 'common'
  end

  def get
    @reader.read
  end

end


describe UserInfo do

  context 'use described_class' do
    subject(:user) { described_class.new(:name => 'name1') }
    it 'described_class return the describe class ' do
      expect(user.name).to eq('name1')
    end
  end

  context 'instance_double' do
    it 'should double any method in  undefined class' do
      user = instance_double('User', :name => 'test1')
      allow(user).to receive(:load) { 12 }
      expect(user.load).to eq(12)
    end

    it 'should only double defined method in defined class' do
      user = instance_double('UserInfo', :name => 'test1')
      allow(user).to receive(:password) { 12 }
      expect(user.password).to eq(12)
    end

    it 'should raise exception when  double undefined method in defined class' do
      user = instance_double('UserInfo', :name => 'test1')
      allow(user).to receive(:load) { 12 }
      expect { user.load }.to raise_error(NoMethodError)
    end

  end

  context 'double' do
    it 'can mock any method' do
      user= double()
      allow(user).to receive(:fuc1) { 12 }
      expect(user.fuc1).to eq(12)
    end
  end

  context 'expect receive, used to test called logic' do
    subject(:user) { described_class.new(:name => 'name1') }
    it do
      member = double()
      expect(member).to receive(:price).with("common").and_return(12)
      allow(member).to receive(:pri_mock)

      user.compute_price(member)

      expect(member).to have_received(:pri_mock)
      expect(user.price).to eq(12)
    end
  end

  context 'as_null_method respond to all messages' do
    subject(:user) { described_class.new(:name => 'name1') }
    it do
      member = double().as_null_object

      user.compute_price(member)

      expect(member).to have_received(:price)
    end
  end


  context 'stub and expect called' do
    subject(:user) { described_class.new(:name => 'name1') }
    it do
      expect(user.reader).to receive(:read).and_return({msg: 'success'})
      expect(user.get).to eql({msg: 'success'})
    end

  end
end