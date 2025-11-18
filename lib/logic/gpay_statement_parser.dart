import 'package:doshi/riverpod/states.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class Transaction {
  final DateTime dateTime;
  final String description;
  final double amount;
  final bool isExpense;
  final int transactionId;
  final String bank;

  Transaction(
      {required this.dateTime,
      required this.description,
      required this.amount,
      required this.isExpense,
      required this.transactionId,
      required this.bank});

  @override
  String toString() {
    return 'Date: ${DateFormat('dd MMM yyyy, hh:mm a').format(dateTime)}, '
        'IsExpense: $isExpense, Amount: ₹${amount.toStringAsFixed(2)}, '
        'Description: $description';
  }

  Map<String, dynamic> toJson() {
    return {
      'date': DateFormat('dd MMM yyyy').format(dateTime),
      'time': DateFormat('hh:mm a').format(dateTime),
      'dateTime': dateTime.toIso8601String(),
      'description': description,
      'amount': amount,
      'isExpense': isExpense,
      'transactionID': transactionId,
      'bank': bank
    };
  }
}

class GpayStatementParser {
  List<Transaction> parsePdfText(List<String> pdftext, WidgetRef ref) {
    List<Transaction> transactions = [];
    List<String> temp = [];
    for (var element in pdftext) {
      temp.add(element.trim().replaceAll(',', ''));
    }
    for (int i = 0; i < temp.length - 4; i++) {
      late bool isExpense;
      late DateTime dateTime;
      late int transactionId;
      String description = "";
      late double amount;
      String bank = "";
      if (i != 0 && i < temp.length - 5) {
        String dateString =
            "${temp[i].trim()} ${temp[i + 1].trim()} ${temp[i + 2].trim()} ${temp[i + 3].trim()} ${temp[i + 4].trim()}";
        DateFormat format = DateFormat('dd MMM yyyy hh:mm a');
        try {
          dateTime = format.parse(dateString);
          try {
            if (temp[i + 5].toLowerCase() == "paid") {
              isExpense = true;
            } else if (temp[i + 5].toLowerCase() == "received") {
              isExpense = false;
            }

            int j = 7;
            while (temp[i + j].trim().toLowerCase() != "upi") {
              description += temp[i + j];
              j++;
            }
            while (!temp[i + j].trim().toLowerCase().contains("id:") &&
                i + j < temp.length - 1) {
              j++;
            }
            transactionId = int.parse(temp[i + j + 1].toLowerCase().trim());
            while (!temp[i + j]
                    .trim()
                    .toLowerCase()
                    .contains(isExpense ? "by" : "to") &&
                i + j < temp.length - 1) {
              j++;
            }
            int l = 0;
            while (!temp[i + j + 1]
                    .trim()
                    .toLowerCase()
                    .contains(ref.read(currencyProvider)) &&
                l < 5) {
              bank += temp[i + j + 1];
              j++;
              l++;
            }
            while (!temp[i + j]
                    .trim()
                    .toLowerCase()
                    .contains(ref.read(currencyProvider)) &&
                i + j < temp.length - 1) {
              j++;
            }
            try {
              amount = double.parse(temp[i + j]
                  .trim()
                  .replaceAll(ref.read(currencyProvider), ''));
              Transaction tempTrans = Transaction(
                  dateTime: dateTime,
                  description: description,
                  amount: amount,
                  isExpense: isExpense,
                  transactionId: transactionId,
                  bank: bank);
              print(bank);
              transactions.add(tempTrans);
            } catch (e) {
              print(
                  "$e : Check if the selected currency symbol matches the one in the statement");
            }
          } catch (e) {
            print(e);
          }
        } catch (e) {
          continue;
        }
      }
    }
    return transactions;
  }
}
