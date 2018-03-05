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
  end
end
