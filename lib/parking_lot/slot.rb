module ParkingLot
  class Slot
    attr_accessor :number, :car

    def initialize(number)
      @number = number
    end
  end
end
