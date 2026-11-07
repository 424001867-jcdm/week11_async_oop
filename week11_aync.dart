// Week 11: Asynchronous Programming in Dart - Async OOP Integration
// Author: John Carlo Macabangon
// Course: PC16 - Mobile Development with Lab (National Teachers College)

// Base hardware class from Week 10 hierarchy
class HardwareComponent {
  String brand;
  String model;
  double _price;

  HardwareComponent(this.brand, this.model, this._price);

  double get price => _price;
  set price(double p) {
    if (p > 0) _price = p;
  }

  void displayDetails() {
    print("Base Hardware: $brand $model | Price: PHP ${_price.toStringAsFixed(2)}");
  }
}

// Derived Processor class with an added asynchronous method
class Processor extends HardwareComponent {
  int coreCount;
  double clockSpeedGhz;

  Processor(String brand, String model, double price, this.coreCount, this.clockSpeedGhz)
      : super(brand, model, price);

  @override
  void displayDetails() {
    print("Processor [CPU]: $brand $model | Cores: $coreCount | Clock: ${clockSpeedGhz}GHz | Price: PHP ${_price.toStringAsFixed(2)}");
  }

  // ASYNCHRONOUS METHOD: Returns a Future simulating cloud inventory database synchronization
  Future<String> saveRecordToCloudAsync() async {
    print(" -> [Async Routine Started]: Connecting to inventory cloud database for $brand $model...");

    // Simulate a realistic 2-second network/database delay without locking the main thread
    await Future.delayed(Duration(seconds: 2));

    return " -> [Async Routine Complete]: Successfully synced $brand $model to central server inventory!";
  }
}

void main() async {
  print('=============================================');
  print(' PC16 Week 11: Asynchronous OOP Program Test ');
  print('=============================================\n');

  Processor myCpu = Processor("AMD", "Ryzen 5 5600", 6500.00, 6, 3.7);
  myCpu.displayDetails();

  print('\n--- Testing Asynchronous Non-Blocking Flow ---');

  // Trigger the asynchronous method (returns a Future)
  Future<String> syncFuture = myCpu.saveRecordToCloudAsync();

  // PROVE NON-BLOCKING: This statement prints immediately *before* the 2-second delay resolves
  print(" [Main Thread]: Continuing local system UI rendering and task logging while sync happens in background...");

  // Await the completion of the future and print the result
  String syncResult = await syncFuture;
  print(syncResult);

  print('\n=============================================');
  print('         Asynchronous Execution Complete     ');
  print('=============================================');
}
