import 'package:flutter/material.dart';
import 'package:loan_manager/components/constants.dart';
import 'package:loan_manager/components/single_loan.dart';
import 'package:loan_manager/models/loan_manager.dart';
import 'package:loan_manager/models/loan_model.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
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
    List<Loan> loans = Provider.of<LoanModel>(context).allLoans;

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
              "$currencyAfn ${result[index].amount}",
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
    List<Loan> loans = Provider.of<LoanModel>(context).allLoans;

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
              "$currencyAfn ${result[index].amount}",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
