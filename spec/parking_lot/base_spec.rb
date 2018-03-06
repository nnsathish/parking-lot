RSpec.describe ParkingLot::Base do
  let!(:lot_2_slots) { ParkingLot::Base.new(2) }
  let!(:lot_3_slots) { ParkingLot::Base.new(3) }
  let!(:white_car) { ParkingLot::Car.new('TN-22-CQ-2455', 'White') }
  let!(:red_car) { ParkingLot::Car.new('TN-01-CQ-1255', 'Red') }

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

  describe '#park' do
    subject { lot_2_slots.park(white_car) }
    context 'when a slot is available' do
      it do
        is_expected.not_to be_nil
        expect(lot_2_slots.slots.first.car).to eq(white_car)
      end
    end
    context 'when no slots are available' do
      before do
        lot_2_slots.park(ParkingLot::Car.new('MH-23-Q-355', 'Yellow'))
        lot_2_slots.park(red_car)
        expect_any_instance_of(ParkingLot::Slot).not_to receive(:park!)
      end
      it { is_expected.to eq 'Sorry, parking lot is full' }
    end
    context 'when a car is already parked' do
      before do
        lot_2_slots.park(white_car)
        expect(lot_2_slots).not_to receive(:next_available_slot)
        expect_any_instance_of(ParkingLot::Slot).not_to receive(:park!)
      end
      it { is_expected.to be_nil }
    end
  end

  describe '#leave' do
    subject { lot_2_slots.leave(slot_no) }
    context 'when slot_no is invalid' do
      let(:slot_no) { 4 } # out of boundary
      it { is_expected.to eq 'Not Found' }
    end
    context 'when slot_no is valid' do
      before { lot_2_slots.park(red_car) }
      let(:slot_no) { 1 }
      it { is_expected.to eq 'Slot number 1 is free' }
    end
  end

  describe '#status' do
    subject { lot_2_slots.status }
    context 'when no car is parked' do
      it { is_expected.to eq '' }
    end
    context 'when a car is parked' do
      before { lot_2_slots.park(white_car) }
      it { is_expected.to eq "Slot No.\tRegistration No\tColour\n1\t#{white_car.reg_no}\t#{white_car.colour}" }
    end
  end

  describe '#registration_numbers_for_cars_with_colour' do
    let!(:another_white_car) { ParkingLot::Car.new('TN-01-A-1234', 'White') }
    subject { lot_3_slots.registration_numbers_for_cars_with_colour(color) }
    context 'when no cars are parked' do
      let(:color) { 'White' }
      it { is_expected.to eq 'Not Found' }
    end
    context 'when cars are parked' do
      before do
        lot_3_slots.park(white_car)
        lot_3_slots.park(red_car)
        lot_3_slots.park(another_white_car)
      end
      context 'when no car matches the color' do
        let(:color) { 'Blue' }
        it { is_expected.to eq 'Not Found' }
      end
      context 'when a car matches the color' do
        let(:color) { 'Red' }
        it { is_expected.to eq red_car.reg_no }
      end
      context 'when multiple cars matches the color' do
        let(:color) { 'White' }
        it { is_expected.to eq [white_car.reg_no, another_white_car.reg_no].join(", ") }
      end
      context 'with a case mismatched color value' do
        let(:color) { 'white' }
        it { is_expected.to eq [white_car.reg_no, another_white_car.reg_no].join(", ") }
      end
    end
  end

  # ideal scenario for shared_examples!
  describe '#slot_numbers_for_cars_with_colour' do
    let!(:another_white_car) { ParkingLot::Car.new('TN-01-A-1234', 'White') }
    subject { lot_3_slots.slot_numbers_for_cars_with_colour(color) }
    context 'when no cars are parked' do
      let(:color) { 'White' }
      it { is_expected.to eq 'Not Found' }
    end
    context 'when cars are parked' do
      before do
        lot_3_slots.park(white_car)
        lot_3_slots.park(red_car)
        lot_3_slots.park(another_white_car)
      end
      context 'when no car matches the color' do
        let(:color) { 'Blue' }
        it { is_expected.to eq 'Not Found' }
      end
      context 'when a car matches the color' do
        let(:color) { 'Red' }
        it { is_expected.to eq 2 }
      end
      context 'when multiple cars matches the color' do
        let(:color) { 'White' }
        it { is_expected.to eq '1, 3' }
      end
      context 'with a case mismatched color value' do
        let(:color) { 'white' }
        it { is_expected.to eq '1, 3' }
      end
    end
  end

  describe '#slot_number_for_registration_number' do
    subject { lot_2_slots.slot_number_for_registration_number(reg_no) }
    context 'when no cars are parked' do
      let(:reg_no) { white_car.reg_no }
      it { is_expected.to eq 'Not Found' }
    end
    context 'when cars are parked' do
      before do
        lot_2_slots.park(white_car)
        lot_2_slots.park(red_car)
      end
      context 'when no car matches the reg_no' do
        let(:reg_no) { 'KL-02-A-999' }
        it { is_expected.to eq 'Not Found' }
      end
      context 'when a car matches the reg_no' do
        let(:reg_no) { white_car.reg_no }
        it { is_expected.to eq 1 }
      end
      context 'with a case mismatched reg_no value' do
        let(:reg_no) { red_car.reg_no.downcase }
        it { is_expected.to eq 2 }
      end
    end
  end
end
