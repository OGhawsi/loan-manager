import 'package:flutter/material.dart';
import 'package:loan_manager/models/loan_manager.dart';

class LoanModel extends ChangeNotifier {
  final List<Loan> _loans = [
    Loan(
      name: "Rahim",
      amount: 300,
      date: DateTime.now(),
      payments: [Payment(1, 200.0, DateTime.now())],
    ),
    Loan(
      name: "Ahmad",
      amount: 500,
      date: DateTime.now(),
      payments: [Payment(2, 100.0, DateTime.now())],
    ),
    Loan(
      payments: [Payment(3, 50.0, DateTime.now())],
      name: "Wali",
      amount: 260,
      date: DateTime.now(),
    ),
  ];
  // List<Payment> _payments = [];

  void addPayment(Loan loan, Payment payment) {
    loan.payments.add(payment);
    // _payments = loan.payments!;

    notifyListeners();
  }

  // getters
  // get allPayments => _payments;
  get allLoans => _loans;

  List<Payment>? getPayments(Loan loan) {
    if (loan.payments != null) {
      return loan.payments;
    } else {
      return [];
    }
  }

  int? getPaymentCount(Loan loan) {
    return loan.payments?.length != null ? loan.payments!.length : 0;
  }

  void addLoan(Loan borrower) {
    _loans.add(borrower);

    notifyListeners();
  }

  // calc totals for each user

  double? calculateTotalPayments(List<Payment>? payments) {
    double value = 0;
    if (payments == null) {
      return 0.0;
    } else {
      for (var payment in payments) {
        value = value + payment.amount;
      }
      return value;
    }

    // return payments!.fold(0, (total, payment) => total + payment.amount);
  }

  double? calculateRemainingLoanAmount(Loan loan) {
    double? totalPayments = calculateTotalPayments(loan.payments);
    // notifyListeners();
    return loan.amount - totalPayments!;
  }

// double calculateOverAllTotalPayments() {}

  double calculatePendingLoansAmount(List<Loan> loans) {
    double totalPaments = 0.0;

    for (var loan in loans) {
      var loanPayments = calculateTotalPayments(loan.payments);
      totalPaments = totalPaments + loanPayments!;
    }
    double totalLoans = loans.fold(0, (total, loan) => total + loan.amount);
    // notifyListeners();
    return totalLoans - totalPaments;
  }
}
