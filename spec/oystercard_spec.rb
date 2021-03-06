require 'oystercard'

describe Oystercard do
let(:subject) { Oystercard.new }
let(:card) { Oystercard.new(20) }
let(:station) {double :station}

  it "has a balance" do
    expect(subject.balance).to eq(0)
  end

  it "tops up balance with" do
    expect { subject.top_up(10) }.to change { subject.balance }.by(10)
  end

  it "errors with over limit" do
    expect { subject.top_up(Oystercard::MAX_BALANCE + 1) }.to raise_error "reached max limit"
  end

  xit "deducts a fare from card" do
    expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
  end

  it 'should be in journey when touched in' do
    card.touch_in(station)
    expect(card).to be_in_journey
  end

  it 'should then not be in journey' do
    card.touch_in(station)
    card.touch_out
    expect(card).not_to be_in_journey
  end

  it "saves the entry station" do
    card.touch_in(station)
    expect(card.entry_station).to eq station
  end

  it 'should deduct minimum fare' do
    card.touch_in(station)
    expect { card.touch_out }.to change { card.balance }.by(-Oystercard::MIN_FARE)
  end

  it 'raises error if balance too low' do
    expect {subject.touch_in(station)}.to raise_error("insufficient funds")
  end
end
