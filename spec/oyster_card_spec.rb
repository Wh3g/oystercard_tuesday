require './lib/oystercard.rb'

describe OysterCard do
  describe '#balance' do
    it 'must have a default balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end
end