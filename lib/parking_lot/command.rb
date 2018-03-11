module ParkingLot
  class Command

    attr_accessor :lot_base, :args

    def initialize(lot_base, args)
      @lot_base = lot_base
      @args = args
    end

    def run
      raise "Please implement in subclass"
    end
  end
end
