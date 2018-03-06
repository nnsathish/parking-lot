require 'parking_lot/slot' 
require 'parking_lot/car'
require 'parking_lot/status_builder'

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

    def leave(slot_no)
      slot = @slots.detect { |s| s.number == slot_no.to_i }
      return 'Not Found' unless slot
      slot.leave!
    end

    def status
      slots = slots_parked
      return '' unless slots.any?

      StatusBuilder.generate(slots)
    end

    def registration_numbers_for_cars_with_colour(color)
      with_slots_for_car_color(color) { |s| s.car.reg_no }
    end

    def slot_numbers_for_cars_with_colour(color)
      with_slots_for_car_color(color) { |s| s.number }
    end

    def slot_number_for_registration_number(reg_no)
      s = @slots.detect do |s|
        s.car && s.car.with_reg_no?(reg_no)
      end
      s ? s.number : 'Not Found'
    end

    private

    def cars_parked
      @slots.map(&:car).compact
    end

    def already_parked?(car)
      cars_parked.map(&:reg_no).include?(car.reg_no)
    end

    def slots_parked
      @slots.select { |s| !s.free? }
    end

    def with_slots_for_car_color(color)
      data = @slots.map do |s|
        next unless s.car && s.car.with_color?(color)
        yield(s)
      end.compact
      data.empty? ? 'Not Found' : data.join(', ')
    end
  end
end
