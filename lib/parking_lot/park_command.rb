module ParkingLot
  class ParkCommand < Command
    def run
      car = Car.new(args.first, args.last)
      lot_base.park(car)
    end
  end
end
