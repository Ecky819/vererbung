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

void main1() {
  // Creating instances of Hammer and Saw
  Hammer hammer = Hammer('DeWalt', 'DWHM100', 29.99, 1.5);
  Saw saw = Saw('Bosch', 'BSH123', 49.99, 'Kreissäge');
  // Displaying information about the tools
  print('Hammer Information:');
  hammer.displayInfo();
  print('\nSaw Information:');
  saw.displayInfo();
}

// Aufgabe 2:
class Grocery {
  // Attributes
  String name;
  String brand;
  double weight;
  double price;

  // Constructor for Grocery
  Grocery(this.name, this.brand, this.weight, this.price);

  // Method to display grocery information
  void displayInfo() {
    print('Name: $name');
    print('Brand: $brand');
    print('Weight: $weight kg');
    print('Price: $price');
  }
}

class Milk extends Grocery {
  // Additional attribute for Milk
  double fatContent;

  // Constructor for Milk
  Milk(String name, String brand, double weight, double price, this.fatContent)
    : super(name, brand, weight, price);

  // Overriding the displayInfo method
  @override
  void displayInfo() {
    super.displayInfo();
  }
}

class Butter extends Grocery {
  // Additional attribute for Butter
  String type;
  // Constructor for Butter
  Butter(String name, String brand, double weight, double price, this.type)
    : super(name, brand, weight, price);
  // Overriding the displayInfo method
  @override
  void displayInfo() {
    super.displayInfo();
  }
}

void main2() {
  // Creating instances of Milk and Butter
  Milk milk = Milk('Milk', 'Alpenmilch', 1.0, 1.20, 3.5);
  Butter butter = Butter('Butter', 'Landliebe', 0.25, 2.50, 'Süßrahmbutter');

  // Displaying information about the groceries
  print('Milk Information:');
  milk.displayInfo();
  print('\nButter Information:');
  butter.displayInfo();
}
