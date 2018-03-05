RSpec.describe ParkingLot::Slot do
  let!(:slot) { ParkingLot::Slot.new(1) }
  let!(:white_ka_car) { ParkingLot::Car.new('KA-03-MX-3455', 'White') }
  let!(:red_ka_car) { ParkingLot::Car.new('KA-03-MX-3455', 'Red') }

  describe '#initialize' do
    subject(:new_slot) { ParkingLot::Slot.new(2) }
    it do
      is_expected.to be_instance_of(ParkingLot::Slot)
      expect(new_slot.number).to eq(2)
    end
  end

  describe '#park!' do
    subject { slot.park!(car) }
    context 'when slot is empty' do
      let(:car) { white_ka_car }
      it do
        is_expected.to eq('Allocated slot number: 1')
        expect(slot.car).to eq(white_ka_car)
      end
    end
    context 'when slot is not empty' do
      let(:car) { red_ka_car }
      before { slot.car = white_ka_car }
      it do
        is_expected.to eq(nil)
        expect(slot.car).to eq(white_ka_car)
      end
    end
  end

  describe '#leave!' do
    subject { slot.leave! }
    context 'when slot is empty' do
      it do
        is_expected.to eq(nil)
        expect(slot.car).to eq(nil)
      end
    end
    context 'when slot is not empty' do
      before { slot.park!(red_ka_car) }
      it do
        is_expected.to eq('Slot number 1 is free')
        expect(slot.car).to eq(nil)
      end
    end
  end

  describe '#free?' do
    subject { slot.free? }
    context 'when slot is empty' do
      it { is_expected.to be_truthy }
    end
    context 'when slot is not empty' do
      before { slot.park!(red_ka_car) }
      it { is_expected.to be_falsey }
    end
  end
end
