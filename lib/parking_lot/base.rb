require 'parking_lot/slot'
require 'parking_lot/car'

module ParkingLot
  class Base
    attr_accessor :slots, :next_available_slot

    def initialize(no_of_slots = 0)
      @slots = []
      no_of_slots.times do |i|
        @slots << Slot.new(i+1)
      end
      @next_available_slot = 1
    end
  end
end
