require 'rspec'
class Options
  attr_accessor :op1
  def initialize op1
    self.op1 = op1
  end

  def add op2
    return self.op1 + op2
  end

  def div op2
    return self.op1/op2
  end
end

describe Options do
  subject {described_class.new 10}

  describe 'Add' do

    context 'op2 more than 0' do
      it 'should return sum op1+op2' do
        expect(subject.add 5).to eq(15)
      end
    end

    context 'op2 less than 0' do
      it 'should return sum op1+op2' do
        expect(subject.add -5).to eq(5)
      end
    end
  end


  describe 'Div' do
    context 'op2 is not 0' do
      it 'should return op1/op2' do
        expect(subject.div 2).to eq(5)
      end
    end

    #catch exception
    context 'op2 is  0' do
      it 'should return op1/op2' do
        expect{subject.div 0}.to raise_error
      end
    end
  end
end




describe 'let' do

  let(:name) {'des'}
  context 'context' do
    let(:name) {'context'}#define_method
    it 'hha' do
      p name

    end
  end

end



# describe 'My behaviour' do
#   describe "in des1" do
#     p 'in des1'
#     before do
#       p 'before in des1'
#     end
#     let(:str1) {  p "in let"; User.fetch }
#
#       subject {
#         p "in subject"
#         str1
#       }
#
#     context 'in context1' do
#       p 'in context1'
#       before do
#         p 'before in context1'
#       end
#
#       it 'it1' do
#         p 'in it1'
#
#         expect(1).to eq(1)
#       end
#
#       it 'it2' do
#         p 'in it2'
#       end
#
#     end
#   end
# end