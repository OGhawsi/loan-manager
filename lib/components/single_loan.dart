import 'package:flutter/material.dart';
import 'package:loan_manager/models/loan_manager.dart';
import 'package:loan_manager/models/loan_model.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SingleLoan extends StatefulWidget {
  const SingleLoan({
    super.key,
    required this.borrower,
  });

  final Loan borrower;

  @override
  State<SingleLoan> createState() => _SingleLoanState();
}

class _SingleLoanState extends State<SingleLoan> {
  final TextEditingController _paymentController = TextEditingController();

  // payments

  var loanModel = LoanModel();

  // String get borrowe => borrower.borrower;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.borrower.name),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Add recieved amount'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _paymentController,
                  decoration: const InputDecoration(hintText: "Amount: \$35.6"),
                  keyboardType: TextInputType.number,
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // call LoanModel frm here
                  if (_paymentController.text == '') {
                    return;
                  }
                  Provider.of<LoanModel>(context, listen: false).addPayment(
                    widget.borrower,
                    Payment(
                      amount: double.parse(_paymentController.text),
                      date: DateTime.now(),
                    ),
                  );
                  _paymentController.clear();
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, bottom: 16, right: 24, left: 26),
                child: Consumer<LoanModel>(
                  builder: (context, value, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // titles and pending amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "P a i d / T o t a l",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                          // consumer
                          Row(
                            children: [
                              // we could use a stack here
                              Text(
                                "Pending",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "\$${value.calculateRemainingLoanAmount(widget.borrower)}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      // initial total and paid amount- COnsumer
                      Row(
                        children: [
                          Text(
                            "\$${value.getPaidAmount(widget.borrower)}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "/ \$${value.getInitialAmount(widget.borrower)}",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // paid amount progress bar with Consumer
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LinearPercentIndicator(
                            width: 320,
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 1000,
                            percent: value.getPaidAmount(widget.borrower) /
                                value.getInitialAmount(widget.borrower),
                            center: Text(
                              "${(value.getPaidAmount(widget.borrower) / value.getInitialAmount(widget.borrower) * 100).toStringAsFixed(2)}%",
                              style: const TextStyle(color: Colors.white),
                            ),
                            barRadius: const Radius.circular(16),
                            progressColor: Colors.grey.shade800,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Payments tile
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 20),
                child: Text(
                  "Recent payments",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ],
          ),
          Consumer<LoanModel>(
            builder: (context, value, child) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, right: 8, left: 8, bottom: 8),
                child: ListView.builder(
                  itemCount: value.getPaymentCount(widget.borrower),
                  itemBuilder: (context, index) {
                    // print(value.getPayments(widget.borrower)![0].amount);
                    return ListTile(
                      title: Text(
                        "\$${value.getPayments(widget.borrower)![index].amount}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      // helper function to change date to human readable form
                      trailing: Text(
                        value.getTimeAgo(
                            value.getPayments(widget.borrower)![index].date),
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// add textfield to set paid amount as transaction
// implement autoincrement for ID.
