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
        it { expect(base.slots.count).to eq(MAX_ALLOWED_SLOTS) }
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
end
