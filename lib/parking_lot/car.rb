module ParkingLot
  class Car
    attr_accessor :reg_no, :color
    
    def initialize(reg_no, color)
      @reg_no = reg_no
      @color = color
    end

    def with_color?(color)
      self.color.downcase == color.downcase
    end

    def with_reg_no?(reg_no)
      self.reg_no.downcase == reg_no.downcase
    end
  end
end
