module ParkingLot
  class RegNoForColorCommand < Command
    def run
      lot_base.registration_numbers_for_cars_with_colour(args.first)
    end
  end
end
