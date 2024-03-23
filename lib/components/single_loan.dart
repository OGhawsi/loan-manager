import 'package:flutter/material.dart';
import 'package:loan_manager/helpers/total_loans_helper.dart';
import 'package:loan_manager/models/loan_manager.dart';

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

  List<Payment> _payments = [];

  @override
  void initState() {
    _payments = widget.borrower.payments;
    super.initState();
  }

  void addPayment() {
    setState(() {
      if (_paymentController.text == '') {
        return;
      }
      widget.borrower.payments.add(
        Payment(
          5,
          double.parse(_paymentController.text),
          DateTime.now(),
        ),
      );
      _paymentController.clear();

      _payments = widget.borrower.payments;
    });
  }

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
                  Navigator.pop(context, 'Add');
                  addPayment();
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
                          Text(
                            "\$${calculateRemainingLoanAmount(widget.borrower)}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
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
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 0.0, right: 8, left: 8, bottom: 8),
              child: ListView.builder(
                itemCount: _payments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "\$${_payments[index].amount}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    // helper function to change date to human readable form
                    trailing: Text(
                      _payments[index].date.toLocal().toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 12),
                    ),
                  );
                },
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
