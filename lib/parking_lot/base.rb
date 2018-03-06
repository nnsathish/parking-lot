require 'parking_lot/slot'
require 'parking_lot/car'

module ParkingLot
  class Base
    attr_accessor :slots

    def initialize(no_of_slots = 0)
      no_of_slots = no_of_slots.to_i
      # Memory optimization: Ensure 50 slots max
      if no_of_slots > MAX_ALLOWED_SLOTS
        no_of_slots = MAX_ALLOWED_SLOTS
      end

      @slots = []
      no_of_slots.times do |i|
        @slots << Slot.new(i+1)
      end
    end

    def next_available_slot
      @slots.detect(&:free?) # slots are pre-ordered
    end

    def park(car)
      return if already_parked?(car)

      slot = next_available_slot
      return 'Sorry, parking lot is full' unless slot

      slot.park!(car)
    end

    private

    def cars_parked
      @slots.map(&:car).compact
    end

    def already_parked?(car)
      cars_parked.map(&:reg_no).include?(car.reg_no)
    end
  end
end
