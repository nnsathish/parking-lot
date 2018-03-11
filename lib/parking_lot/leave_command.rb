module ParkingLot
  class LeaveCommand < Command
    def run
      lot_base.leave(args.first)
    end
  end
end
