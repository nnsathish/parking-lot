RSpec.describe ParkingLot::Car do
  let!(:white_car) { ParkingLot::Car.new('KA-01-A-1334', 'White') }
  let!(:black_car) { ParkingLot::Car.new('TMD-001', 'Black') }

  describe 'initialize' do
    subject(:new_car) { ParkingLot::Car.new('TN-22-C-1344', 'White') }
    it do
      is_expected.to be_instance_of(ParkingLot::Car)
      expect(new_car.reg_no).to eq 'TN-22-C-1344'
      expect(new_car.color).to eq 'White'
    end
  end

  describe '#with_color?' do
    subject { white_car.with_color?(color) }
    context 'when color does not match' do
      let(:color) { 'Red' }
      it { is_expected.to be_falsey }
    end
    context 'when color is matched' do
      let(:color) { 'white' }
      it { is_expected.to be_truthy }
    end
  end

  describe '#with_reg_no?' do
    subject { black_car.with_reg_no?(reg_no) }
    context 'when reg_no does not match' do
      let(:reg_no) { 'random' }
      it { is_expected.to be_falsey }
    end
    context 'when reg_no is matched' do
      let(:reg_no) { black_car.reg_no }
      it { is_expected.to be_truthy }
    end
  end
end
