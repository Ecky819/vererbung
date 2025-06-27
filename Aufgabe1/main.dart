// Aufgabe 1:
class Tool {
  // Attribute
  String brand;
  String model;
  double price;
  // Constructor
  Tool(this.brand, this.model, this.price);
  // Method to display tool information
  void displayInfo() {
    print('Brand: $brand');
    print('Model: $model');
    print('Price: $price');
  }
}

class Hammer extends Tool {
  // Additional attribute for Hammer
  double weight;

  // Constructor for Hammer
  Hammer(String brand, String model, double price, this.weight)
    : super(brand, model, price);

  void displayWeight() {
    print('Weight: $weight kg');
  }
}

class Saw extends Tool {
  // Additional attribute for Saw
  String type;

  // Constructor for Saw
  Saw(String brand, String model, double price, this.type)
    : super(brand, model, price);

  void displayType() {
    print('Type: $type');
  }
}

void main() {
  // Creating instances of Hammer and Saw
  Hammer hammer = Hammer('DeWalt', 'DWHM100', 29.99, 1.5);
  Saw saw = Saw('Bosch', 'BSH123', 49.99, 'Kreissäge');
  // Displaying information about the tools
  print('Hammer Informationen:');
  hammer.displayInfo();
  hammer.displayWeight();
  print('\nSägen Informationen:');
  saw.displayInfo();
  saw.displayType();
}
