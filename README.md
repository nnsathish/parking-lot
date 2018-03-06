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

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
