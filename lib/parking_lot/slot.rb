module ParkingLot
  class Slot
    attr_accessor :number, :car

    def initialize(number)
      @number = number
    end

    def park!(car)
      return unless free?

      self.car = car # TODO::Update Base#next_available_slot!!
      'Allocated slot number: ' << self.number.to_s
    end

    def leave!
      return if free?

      self.car = nil
      "Slot number #{self.number} is free"
    end

    def free?
      car.nil?
    end
  end
end
