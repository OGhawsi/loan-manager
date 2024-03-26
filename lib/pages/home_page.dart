import 'package:flutter/material.dart';
import 'package:loan_manager/components/single_loan.dart';
import 'package:loan_manager/models/loan_manager.dart';
import 'package:loan_manager/models/loan_model.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // var loanModel = LoanModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loan Manager"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(
            width: 16.0,
          )
        ],
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
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Borrower name",
                  ),
                  keyboardType: TextInputType.name,
                ),
                TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(hintText: "Amount: \$35.6"),
                  keyboardType: TextInputType.number,
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Add');
                  // addBorrower();
                  if (_amountController.text == '' ||
                      _nameController.text == '') {
                    return;
                  } else {
                    Provider.of<LoanModel>(context, listen: false).addLoan(
                      Loan(
                        name: _nameController.text,
                        amount: double.parse(_amountController.text),
                        date: DateTime.now(),
                        // payments: [Payment(1, 0, DateTime.now())]
                      ),
                    );
                  }

                  _nameController.clear();
                  _amountController.clear();
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
        child: const Icon(Icons.add),
      ),
      drawer: const Drawer(),
      body: Column(
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
                  child: Consumer<LoanModel>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loans",
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 18),
                            ),
                            Text(
                              "\$${value.calculatePendingLoansAmount(value.allLoans)}",
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
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 20),
                child: Text(
                  "Recent loans",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ],
          ),
          Consumer<LoanModel>(
            builder: (context, model, child) => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: model.allLoans.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return SingleLoan(borrower: model.allLoans[index]);
                          }),
                        );
                      },
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(model.allLoans[index].name),
                      // helper function to change date to human readable form
                      subtitle: Text(
                        model.getTimeAgo(model.allLoans[index].date),
                      ),
                      trailing: Text(
                        "\$${model.calculateRemainingLoanAmount(model.allLoans[index])}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
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

class CustomSearchDelegate extends SearchDelegate {
  List<Loan> loans = LoanModel().allLoans;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Loan> result = [];

    if (query.isEmpty) {
      result = loans;
    } else {
      for (var item in loans) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          result.add(item);
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return SingleLoan(borrower: result[index]);
                }),
              );
            },
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(result[index].name),
            // helper function to change date to human readable form
            subtitle: Text(result[index].date.toLocal().toString()),
            trailing: Text(
              "\$${result[index].amount}",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Loan> result = [];

    if (query.isEmpty) {
      result = loans;
    } else {
      for (var item in loans) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          result.add(item);
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return SingleLoan(borrower: result[index]);
                }),
              );
            },
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(result[index].name),
            // helper function to change date to human readable form
            subtitle: Text(result[index].date.toLocal().toString()),
            trailing: Text(
              "\$${result[index].amount}",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
