class Loan {
  String name;
  double amount;
  DateTime date;
  List<Payment> payments;

  Loan({
    required this.name,
    required this.amount,
    required this.date,
    List<Payment>? payments, //optional parameter
  }) : payments = payments ?? []; //initiliaze the list

  // void addPayment
}

class Payment {
  int id;
  double amount;
  DateTime date = DateTime.now();

  Payment(this.id, this.amount, DateTime dateTime);
}
