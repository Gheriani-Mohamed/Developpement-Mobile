class Wallet {
  final String id;
  final String name;
  final String type; // personal / family / company
  final double balance;
  final List<String>? sharedWith; // optional: userIds for shared wallets

  Wallet({required this.id, required this.name, required this.type, required this.balance, this.sharedWith,});}