# ParkingLot
Simple parking lot manager to automate car parking using CLI and predefined set of commands like
 - create_parking_lot <lots_count>
 - park <car_reg_no> <car_color>
 - leave <slot_no>
 
## Installation
### Dependencies
 - Ruby(MRI) - 2.4.x

From the application root:
```
./parking_lot
```
## Usage
```
./parking_lot <datafilepath>    Executes the commands from <datafilepath> sequentially
./parking_lot                   Let users input commands manually from command prompt
```

## Example Commands
```
create_parking_lot 3
park car1 white
park TN-22-CQ-2343 red
park TMD-001 white
leave 3
leave 6
park car3 white
park car4 black
leave 2
status
park car2 red
status
registration_numbers_for_cars_with_colour white
slot_numbers_for_cars_with_colour blue
slot_number_for_registration_number car
slot_numbers_for_cars_with_colour WHIte
slot_number_for_registration_number car3
slot_number_for_registration_number car4
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
