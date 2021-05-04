require './lib/oyster_card.rb'

describe OysterCard do
  let(:check_in_station) { double("Station", :name => "Holland Park") }
  let(:check_out_station) { double("Station", :name => "Finsbury Park") }
  describe '.new' do
    it 'must have a default balance of 0' do
      expect(subject.balance).to eq(0)
    end
    it 'must have an empty journey history' do
      expect(subject.journey_history.empty?).to eq(true)
    end
  end

  describe '#top_up' do
    it 'adds to the balance' do
      subject.top_up(50)
      expect(subject.balance).to eq(50)
    end
    context "When balance reaches limit of £#{OysterCard::BALANCE_LIMIT}" do
      it 'raises an error' do
        subject.top_up(OysterCard::BALANCE_LIMIT)
       expect { subject.top_up(1) }.to raise_error "Limit of £#{OysterCard::BALANCE_LIMIT} is exceeded"
      end
    end
  end

  describe "#deduct" do
    it "deducts money from the balance" do
      subject.top_up(50)
      subject.touch_out(check_out_station)
      expect(subject.balance).to eq(49)
    end
  end

  describe "#in_journey?" do
    it "returns false when not travelled" do
      expect(subject.in_journey?).to eq false
    end
  end

  describe "#touch_in" do
    context "with sufficient funds" do
      it "begins journey" do
        subject.top_up(50)
        subject.touch_in(check_in_station)
        expect(subject.in_journey?).to eq true
      end
      it "saves the entry station" do
        subject.top_up(10)
        subject.touch_in(check_in_station)
        expect(subject.entry_station).to eq check_in_station
      end
    end
    context "when balance less than £1" do
      it "raises an error" do
        expect { subject.touch_in(check_in_station) }.to raise_error "Insufficient funds."
      end
    end
  end

  describe "#touch_out" do
    it "ends journey" do
      subject.top_up(50)
      subject.touch_out(check_out_station)
      expect(subject.in_journey?).to eq false
    end
    it "deducts the balance by #{OysterCard::MINIMUM_FARE}" do
      subject.top_up(OysterCard::MINIMUM_FARE)
      expect { subject.touch_out(check_out_station) }.to change{ subject.balance }.by(-OysterCard::MINIMUM_FARE)
    end
    context "after checking in and checking out" do
      it "saves journey to journey history" do
        subject.top_up(50)
        subject.touch_in(check_in_station)
        subject.touch_out(check_out_station)
        expect(subject.journey_history.pop).to eq({start: check_in_station, finish: check_out_station})
      end
    end
  end
end
