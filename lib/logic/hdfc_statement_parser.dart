import 'package:doshi/logic/gpay_statement_parser.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class HdfcStatementParser {
  bool isDouble(String s) {
    try {
      double.parse(cleanDoubleString(s));
      return true;
    } catch (e) {
      return false;
    }
  }

  String cleanDoubleString(String s) {
    String newS = "";
    List<String> temp = s.trim().replaceAll(",", "").split('');
    int i = temp.indexWhere((x) => x.trim() == ".");
    int j = 0;
    while (j <= i + 2) {
      newS += temp[j];
      j++;
    }
    return newS;
  }

  List<Transaction> parsePdfText(String pdftext, WidgetRef ref) {
    List<String> stringList = pdftext.split('\n');
    List<String> cleanedStringList = [];
    for (var element in stringList) {
      String temp = element.trim();
      if (temp != "") {
        cleanedStringList.add(temp);
      }
    }
    List<Transaction> transactions = [];
    for (int i = 0; i < cleanedStringList.length; i++) {
      late bool isExpense;
      late DateTime dateTime;
      late int transactionId;
      String description = "";
      late double amount;
      String bank = "HDFC";
      if (i != 0) {
        String dateString = cleanedStringList[i].trim();
        DateFormat format = DateFormat('dd/MM/yy');
        try {
          dateTime = format.parse(dateString);
          if (!isDouble(cleanedStringList[i + 1])) {
            try {
              amount =
                  double.parse(cleanDoubleString(cleanedStringList[i + 4]));
            } catch (e) {
              continue;
            }
            description = cleanedStringList[i + 1].trim();
            transactionId = int.parse(cleanedStringList[i + 2].trim());
            try {
              double.parse(cleanedStringList[i + 4].trim().replaceAll(",", ""));
              isExpense = true;
            } catch (e) {
              isExpense = false;
            }
            print(dateTime);
            print(amount);
            print(description);
            print(transactionId);
            print("");
            transactions.add(Transaction(
                dateTime: dateTime,
                description: description,
                amount: amount,
                isExpense: isExpense,
                transactionId: transactionId,
                bank: bank));
          } else {
            continue;
          }
        } catch (e) {
          continue;
        }
      }
    }
    return transactions;
  }
}
