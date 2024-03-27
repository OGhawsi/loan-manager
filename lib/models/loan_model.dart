import 'package:flutter/material.dart';
import 'package:loan_manager/models/loan_manager.dart';
import 'dart:async';

class LoanModel extends ChangeNotifier {
  final List<Loan> _loans = [
    Loan(
      name: "Rahim",
      amount: 300,
      date: DateTime.now(),
      payments: [Payment(amount: 200.0, date: DateTime.now())],
    ),
    Loan(
      name: "Ahmad",
      amount: 500,
      date: DateTime.now(),
      payments: [Payment(amount: 4.0, date: DateTime.now())],
    ),
    Loan(
      payments: [Payment(amount: 50.0, date: DateTime.now())],
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
    return loan.payments;
  }

  int? getPaymentCount(Loan loan) {
    return loan.payments.length;
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
    return loan.amount - totalPayments!;
  }

  double calculatePendingLoansAmount(List<Loan> loans) {
    double totalPaments = 0.0;

    for (var loan in loans) {
      var loanPayments = calculateTotalPayments(loan.payments);
      totalPaments = totalPaments + loanPayments!;
    }
    double totalLoans = loans.fold(0, (total, loan) => total + loan.amount);
    return totalLoans - totalPaments;
  }
// Return initial lend amount and display on each borrower page

  double getInitialAmount(Loan loan) {
    return loan.amount;
  }

  double getPaidAmount(Loan loan) {
    var payments = loan.payments;

    return payments.fold(0, (total, payment) => total + payment.amount);
  }

  Stream<DateTime> timeStream() {
    return Stream.periodic(const Duration(minutes: 1), (_) => DateTime.now());
  }

  // human readable date

  String getTimeAgo(DateTime pastDate) {
    final now = DateTime.now();
    final difference = now.difference(pastDate);

    if (difference.isNegative) {
      return 'In the future';
    }
    if (difference.inDays >= 365) {
      final years = difference.inDays ~/ 365;
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 30) {
      final months = difference.inDays ~/ 30;
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 7) {
      final weeks = difference.inDays ~/ 7;
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    }
  }
}
