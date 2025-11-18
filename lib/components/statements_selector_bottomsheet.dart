import 'dart:io';

import 'package:doshi/isar/entry.dart';
import 'package:doshi/logic/gpay_statement_parser.dart';
import 'package:doshi/logic/hdfc_statement_parser.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class StatementsSelectorBottomsheet extends ConsumerWidget {
  const StatementsSelectorBottomsheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Transaction> transactions = [];
    return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GestureDetector(
                            onTap: () async {
                              HapticFeedback.heavyImpact();
                              int added = 0;
                              int skipped = 0;
                              try {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf'],
                                );
                                if (result != null) {
                                  File file = File(result.files.single.path!);
                                  // Extract text from PDF using Syncfusion
                                  final PdfDocument document = PdfDocument(
                                      inputBytes: file.readAsBytesSync());
                                  String pdfText =
                                      PdfTextExtractor(document).extractText();
                                  // await FlutterClipboard.copy(pdfText);
                                  transactions = GpayStatementParser()
                                      .parsePdfText(pdfText.split('\n'), ref);
                                  document.dispose();
                                  for (var element in transactions) {
                                    Entry? thisEntry = ref
                                        .read(entryDatabaseProvider)
                                        .where((x) =>
                                            x.id == element.transactionId)
                                        .firstOrNull;
                                    if (thisEntry == null) {
                                      ref
                                          .read(entryDatabaseProvider.notifier)
                                          .addParsedEntry(
                                              element.transactionId,
                                              element.amount,
                                              element.dateTime,
                                              ref.read(categoryText),
                                              element.isExpense
                                                  ? "To ${element.description}"
                                                  : "From ${element.description}",
                                              element.isExpense,
                                              ref.read(categoryColorInt),
                                              false,
                                              ref.read(subCategoryText),
                                              ref.read(subCategoryColorInt));
                                      added++;
                                    } else {
                                      skipped++;
                                    }
                                  }
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                  Navigator.of(context).pop();
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                }
                                return;
                              }
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(added != 0 && skipped != 0
                                        ? "Added $added Transactions And Skipped $skipped"
                                        : skipped != 0
                                            ? "Skipped $skipped Transactions"
                                            : "Added $added Transactions")));
                                Navigator.of(context).pop();
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.lightBlue),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                                child: Text(
                                  "GPay",
                                  softWrap: true,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GestureDetector(
                            onTap: () async {
                              HapticFeedback.heavyImpact();
                              int added = 0;
                              int skipped = 0;
                              try {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf'],
                                );
                                if (result != null) {
                                  File file = File(result.files.single.path!);
                                  // Extract text from PDF using Syncfusion
                                  final PdfDocument document = PdfDocument(
                                      inputBytes: file.readAsBytesSync());
                                  String pdfText =
                                      PdfTextExtractor(document).extractText();
                                  HdfcStatementParser()
                                      .parsePdfText(pdfText, ref);
                                  // await FlutterClipboard.copy(pdfText);
                                  transactions = HdfcStatementParser()
                                      .parsePdfText(pdfText, ref);
                                  document.dispose();
                                  for (var element in transactions) {
                                    Entry? thisEntry = ref
                                        .read(entryDatabaseProvider)
                                        .where((x) =>
                                            x.id == element.transactionId)
                                        .firstOrNull;
                                    if (thisEntry == null) {
                                      ref
                                          .read(entryDatabaseProvider.notifier)
                                          .addParsedEntry(
                                              element.transactionId,
                                              element.amount,
                                              element.dateTime,
                                              ref.read(categoryText),
                                              element.isExpense
                                                  ? "To ${element.description}"
                                                  : "From ${element.description}",
                                              element.isExpense,
                                              ref.read(categoryColorInt),
                                              false,
                                              ref.read(subCategoryText),
                                              ref.read(subCategoryColorInt));
                                      added++;
                                    } else {
                                      skipped++;
                                    }
                                  }
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                  Navigator.of(context).pop();
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                }
                                return;
                              }
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(added != 0 && skipped != 0
                                        ? "Added $added Transactions And Skipped $skipped"
                                        : skipped != 0
                                            ? "Skipped $skipped Transactions"
                                            : "Added $added Transactions")));
                                Navigator.of(context).pop();
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.red),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                                child: Text(
                                  "HDFC",
                                  softWrap: true,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
