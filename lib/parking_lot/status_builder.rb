require 'csv'

module ParkingLot
  module StatusBuilder

    HEADER = ['Slot No.', 'Registration No', 'Colour']

    def self.generate(slots)
      CSV.generate(col_sep: "\t") do |csv|
        csv << HEADER
        slots.each do |s|
          csv << [s.number, s.car.reg_no, s.car.color]
        end
      end.chomp
    end
  end
end
