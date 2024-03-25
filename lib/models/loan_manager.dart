class Loan {
  String name;
  double amount;
  DateTime date;
  List<Payment>? payments;

  Loan({
    required this.name,
    required this.amount,
    required this.date,
    this.payments,
  });

  get allPayments => payments;
}

class Payment {
  int id;
  double amount;
  DateTime date = DateTime.now();

  Payment(this.id, this.amount, DateTime dateTime);
}
