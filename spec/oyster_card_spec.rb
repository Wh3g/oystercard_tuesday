require './lib/oyster_card.rb'

describe OysterCard do
  describe '.new' do
    it 'must have a default balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'adds to the balance' do
      subject.top_up(50)
      expect(subject.balance).to eq(50)
    end
  end
end