require 'singleton'
require 'parking_lot/command'
require 'parking_lot/park_command'
require 'parking_lot/leave_command'
require 'parking_lot/status_command'
require 'parking_lot/reg_no_for_color_command'
require 'parking_lot/slot_no_for_color_command'
require 'parking_lot/slot_no_for_reg_no_command'

module ParkingLot
  class CLI
    include Singleton

    attr_accessor :base

    CREATE_LOT_COMMAND = :create_parking_lot
    SPECIAL_COMMANDS = { status: 0, park: 2 } # other commands take 1 argument

    COMMAND_KLASS_MAP = {
      park: ParkingLot::ParkCommand,
      leave: ParkingLot::LeaveCommand,
      status: ParkingLot::StatusCommand,
      registration_numbers_for_cars_with_colour: ParkingLot::RegNoForColorCommand,
      slot_numbers_for_cars_with_colour: ParkingLot::SlotNoForColorCommand,
      slot_number_for_registration_number: ParkingLot::SlotNoForRegNoCommand
    }

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
      return 'Invalid command' unless allowed_commands.include?(meth)

      req_args_count = SPECIAL_COMMANDS[meth] || 1
      args = args.first(req_args_count)
      return 'Command value is invalid' if args.length < req_args_count

      if meth == CREATE_LOT_COMMAND
        self.base = ParkingLot::Base.new(args.last)
        "Created a parking lot with #{self.base.slots.length} slots"
      else
        return 'Please run create_parking_lot first' unless self.base
        (COMMAND_KLASS_MAP[meth] || ParkingLot::Command).new(self.base, args).run
      end
    end

    private

    # ordering is important, atleast for first command
    def allowed_commands
      @allowed_commands ||= COMMAND_KLASS_MAP.keys.unshift(CREATE_LOT_COMMAND)
    end
  end
end
