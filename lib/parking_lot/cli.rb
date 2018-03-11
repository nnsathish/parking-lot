require 'singleton'

module ParkingLot
  class CLI
    include Singleton

    attr_accessor :base

    ALLOWED_COMMANDS = %i(
      create_parking_lot park leave status registration_numbers_for_cars_with_colour
      slot_numbers_for_cars_with_colour slot_number_for_registration_number
    ) # ordering is important, atleast for first command

    SPECIAL_COMMANDS = { status: 0, park: 2 } # other commands take 1 argument

    def run_with_file(filepath)
      return 'File not found' unless File.file?(filepath)
      return 'File is not readable' unless File.readable?(filepath)

      commands = File.readlines(filepath)
      output = commands.map do |cmd|
        run_command(cmd)
      end
      output
    end

    def run_command(cmd)
      return 'Command is blank' if cmd.to_s.strip.empty?
      meth, *args = cmd.to_s.split(' ')
      meth = meth.to_sym
      return 'Invalid command' unless ALLOWED_COMMANDS.include?(meth)

      req_args_count = SPECIAL_COMMANDS[meth] || 1
      args = args.first(req_args_count)
      return 'Command value is invalid' if args.length < req_args_count

      if meth == ALLOWED_COMMANDS.first
        self.base = ParkingLot::Base.new(args.last)
        "Created a parking lot with #{self.base.slots.length} slots"
      else
        return 'Please run create_parking_lot first' unless self.base
      end
    end
  end
end
