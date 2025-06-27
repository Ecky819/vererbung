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
