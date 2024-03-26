import 'package:flutter/material.dart';
import 'package:loan_manager/models/loan_manager.dart';
import 'package:loan_manager/models/loan_model.dart';
import 'package:provider/provider.dart';

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
            title: const Text('AlertDialog Title'),
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
          Column(
            children: [
              // money card total loan
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Remaining amount",
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 18),
                          ),
                          Consumer<LoanModel>(
                            builder: (context, value, child) => Column(
                              children: [
                                Text(
                                  "\$${value.getInitialAmount(widget.borrower)}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "\$${value.calculateRemainingLoanAmount(widget.borrower)}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance_outlined,
                            size: 100,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
