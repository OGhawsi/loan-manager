// get total loans given out

import 'package:loan_manager/models/loan_manager.dart';

double calculateTotalPayments(List<Payment> payments) {
  return payments.fold(0, (total, payment) => total + payment.amount);
}

double calculateRemainingLoanAmount(Loan loan) {
  double totalPayments = calculateTotalPayments(loan.payments);
  return loan.amount - totalPayments;
}

// double calculateOverAllTotalPayments() {}

double calculatePendingLoansAmount(List<Loan> loans) {
  double totalPaments = 0.0;

  for (var loan in loans) {
    totalPaments = totalPaments + calculateTotalPayments(loan.payments);
  }
  double totalLoans = loans.fold(0, (total, loan) => total + loan.amount);
  return totalLoans - totalPaments;
}
