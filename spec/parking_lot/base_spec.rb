RSpec.describe ParkingLot::Base do
  describe '#initialize' do
    context 'with no arguments' do
      subject(:base) { ParkingLot::Base.new }
      it do
        is_expected.to be_instance_of(ParkingLot::Base)
        expect(base.slots).to be_empty
      end
    end
    context 'when no of slots is passed' do
      subject(:base) { ParkingLot::Base.new(no_of_slots) }
      context 'with valid slots count' do
        let(:no_of_slots) { 5 }
        it { expect(base.slots.count).to eq(no_of_slots) }
      end
      context 'with larger slots count' do
        let(:no_of_slots) { 100 }
        it { expect(base.slots.count).to eq(ParkingLot::MAX_ALLOWED_SLOTS) }
      end
      context 'with invalid count value' do
        let(:no_of_slots) { 'afaf' }
        it { expect(base.slots.count).to eq(0) }
      end
      context 'with nil' do
        let(:no_of_slots) { nil }
        it { expect(base.slots.count).to eq(0) }
      end
    end
  end

  describe '#next_available_slot' do
    let!(:lot_3_slots) { ParkingLot::Base.new(3) }
    let!(:car) { ParkingLot::Car.new('KA-01-P-244', 'Black') }
    subject(:slot) { lot_3_slots.next_available_slot }
    context 'when all slots are free' do
      it do
        is_expected.not_to be_nil
        expect(slot.number).to eq(1)
      end
    end
    context 'when slot1 is occupied' do
      before { lot_3_slots.slots.first.car = car }
      it do
        is_expected.not_to be_nil
        expect(slot.number).to eq(2)
      end
    end
    context 'when slot1 and slot3 are occupied' do
      before do
        lot_3_slots.slots.first.car = car
        lot_3_slots.slots.last.car = car
      end
      it do
        is_expected.not_to be_nil
        expect(slot.number).to eq(2)
      end
    end
    context 'when slot3 is occupied' do
      before { lot_3_slots.slots.last.car = car }
      it do
        is_expected.not_to be_nil
        expect(slot.number).to eq(1)
      end
    end
    context 'when all slots are occupied' do
      before do
        lot_3_slots.slots.each { |s| s.car = car }
      end
      it { is_expected.to be_nil }
    end
  end
end
