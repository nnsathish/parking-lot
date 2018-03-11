module ParkingLot
  class SlotNoForRegNoCommand < Command
    def run
      lot_base.slot_number_for_registration_number(args.first)
    end
  end
end
