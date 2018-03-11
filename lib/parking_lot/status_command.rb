module ParkingLot
  class StatusCommand < Command
    def run
      lot_base.status
    end
  end
end
