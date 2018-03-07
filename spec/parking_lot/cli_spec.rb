RSpec.describe ParkingLot::CLI do
  let(:cli) { ParkingLot::CLI.instance }

  describe '#run_with_file' do
    subject { cli.run_with_file(fpath) }
    context 'when file does not exist' do
      let(:fpath) { 'spec/not_found.txt' }
      it {  is_expected.to eq 'File not found' }
    end
    context 'when file has invalid commands' do
      let(:fpath) { 'spec/data/invalid.txt' }
      it { is_expected.to eq ['Invalid command'] }
    end
    context 'when file has valid commands' do
      let(:fpath) { 'spec/data/sample.txt' }
      it { is_expected.to eq ['Created a parking lot with 2 slots', 'Allocated slot number: 1'] }
    end
  end

  describe '#run_command' do
    before { cli.base = nil } # refresh the singleton object
    subject { cli.run_command(command) }
    context 'when command is blank' do
      let(:command) { '' }
      it { is_expected.to eq 'Command is blank' }
    end
    context 'when command is invalid' do
      let(:command) { 'test_command' }
      it { is_expected.to eq 'Invalid command' }
    end
    context 'when command argument is blank' do
      let(:command) { 'create_parking_lot    ' }
      it { is_expected.to eq 'Command value is invalid' }
    end
    context 'when create_parking_lot is not triggered' do
      let(:command) { 'status' }
      it { is_expected.to eq 'Please run create_parking_lot first' }
    end
    context 'with command that does not require argument' do
      before { cli.run_command('create_parking_lot 2') }
      let(:command) { 'status' }
      it { is_expected.to eq '' }
    end
    context 'with :create_parking_lot command' do
      let(:command) { 'create_parking_lot 3' }
      it { is_expected.to eq 'Created a parking lot with 3 slots' }
    end
    context 'with :create_parking_lot when invalid value' do
      let(:command) { 'create_parking_lot ab#$%c xya' }
      it { is_expected.to eq 'Created a parking lot with 0 slots' }
    end
    context 'with :park command' do
      before { cli.run_command('create_parking_lot 2') }
      let(:command) { 'park abc white' }
      it { is_expected.to eq 'Allocated slot number: 1' }
    end
  end
end
