module ParkingLot
  class SlotNoForColorCommand < Command
    def run
      lot_base.slot_numbers_for_cars_with_colour(args.first)
    end
  end
end
