class Loan {
  String name;
  double amount;
  DateTime date;
  List<Payment> payments;

  Loan({
    required this.name,
    required this.amount,
    required this.date,
    required this.payments,
  });

  
}

class Payment {
  int id;
  double amount;
  DateTime date = DateTime.now();

  Payment(this.id, this.amount, DateTime dateTime);
}
