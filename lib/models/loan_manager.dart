class Loan {
  String name;
  double amount;
  double initialAmount = 0;
  DateTime date;
  List<Payment> payments;

  Loan({
    required this.name,
    required this.amount,
    required this.date,
    List<Payment>? payments, //optional parameter
  })  : payments = payments ?? [],
        initialAmount = amount; //initiliaze the list

  // void addPayment
}

class Payment {
  static int statId = 0;
  int id;
  double amount;
  DateTime date;

  Payment({required this.amount, required this.date}) : id = statId++;
}
