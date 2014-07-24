require 'rspec'
require_relative '../src/back_jack'
describe 'scoreHand' do

  it 'should be closest to 21 when only A' do
    expect(scoreHand(['A'])).to be(11)
  end

  it 'should be closest to 21 when no A' do
    expect(scoreHand(['5','3','7'])).to be(15)
    expect(scoreHand(['5','3','J'])).to be(18)
  end

  it 'should be closest to 21 when A equal 1 and sum more than 21' do
    expect(scoreHand(['5','5','7','4','A'])).to be(22)
    expect(scoreHand(['5','4','3','2','A','K'])).to be(25)
  end

  it 'should be closest to 21 when one A should be 11 and another if has should be 1' do
    expect(scoreHand(['A','J'])).to be(21)
    expect(scoreHand(['A','A','2'])).to be(14)

  end

  it 'should be closest to 21 when second sum more than 21' do
    expect(scoreHand(['A','10','A'])).to be(12)
  end

end