class Wallet {
  final String id;
  final String name;
  final String type; // personal / family / company
  final double balance;

  Wallet({required this.id, required this.name, required this.type, required this.balance});
}