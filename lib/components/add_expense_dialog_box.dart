import 'package:doshi/components/category_list.dart';
import 'package:doshi/components/user_input_dialog.dart';
import 'package:doshi/logic/decimal_text_input_formatter.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AddExpenseDialogBox extends StatefulWidget {
  const AddExpenseDialogBox({super.key});

  @override
  State<AddExpenseDialogBox> createState() => _AddExpenseDialogBoxState();
}

class _AddExpenseDialogBoxState extends State<AddExpenseDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.5),
      child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: ThisContainerFinal()),
    );
  }
}

class ThisContainerFinal extends StatelessWidget {
  const ThisContainerFinal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ThisContainerOfTheDialogBox(
          opacity: 0,
          padBottom: 0,
          padLeft: 8,
          padRight: 0,
          padTop: 8,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        ThisContainerOfTheDialogBox(
          opacity: 1,
          padBottom: 8,
          padLeft: 0,
          padRight: 8,
          padTop: 0,
          color: Theme.of(context).colorScheme.tertiary,
        )
      ],
    );
  }
}

class ThisContainerOfTheDialogBox extends ConsumerStatefulWidget {
  final double padTop;
  final double padBottom;
  final double padLeft;
  final double padRight;
  final Color color;
  final double opacity;
  const ThisContainerOfTheDialogBox({
    super.key,
    required this.padBottom,
    required this.padLeft,
    required this.padRight,
    required this.padTop,
    required this.color,
    required this.opacity,
  });

  @override
  ConsumerState<ThisContainerOfTheDialogBox> createState() =>
      _ThisContainerOfTheDialogBoxState();
}

class _ThisContainerOfTheDialogBoxState
    extends ConsumerState<ThisContainerOfTheDialogBox> {
  final amountTEC = TextEditingController();
  final addNoteTEC = TextEditingController();
  final categoryTEC = TextEditingController();
  DateTime dateTimeVar = DateTime.now();

  @override
  void initState() {
    amountTEC.text = "25";
    categoryTEC.text = "Uncategorised";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.padBottom + MediaQuery.of(context).viewInsets.bottom,
          right: widget.padRight,
          top: widget.padTop,
          left: widget.padLeft),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: widget.color),
            child: Consumer(builder: (context, ref, child) {
              return Padding(
                padding: const EdgeInsets.all(26.0),
                child: Opacity(
                  opacity: widget.opacity,
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: DateFormat('dMMMM').format(dateTimeVar) !=
                                        DateFormat('dMMMM')
                                            .format(DateTime.now())
                                    ? "On "
                                    : ""),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  HapticFeedback.lightImpact();
                                  final DateTime? picked = await showDatePicker(
                                      initialDate: DateTime.now(),
                                      context: context,
                                      firstDate:
                                          DateTime(DateTime.now().year - 10),
                                      lastDate: DateTime.now());
                                  setState(() {
                                    if (picked != null &&
                                        picked != dateTimeVar) {
                                      dateTimeVar = picked;
                                    }
                                  });
                                },
                              text: DateFormat('d MMM yy')
                                          .format(DateTime.now()) ==
                                      DateFormat('d MMM yy').format(dateTimeVar)
                                  ? "Today,"
                                  : DateFormat('d MMM yy,').format(dateTimeVar),
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.amber,
                                  textStyle: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationStyle:
                                          TextDecorationStyle.dashed)),
                            ),
                            const TextSpan(text: " I "),
                            TextSpan(
                              text: "spent",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                color: Colors.redAccent,
                              ),
                            ),
                            const TextSpan(text: " "),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    HapticFeedback.lightImpact();
                                    amountTEC.clear();
                                    ref
                                        .read(amountText.notifier)
                                        .update((state) => "");
                                    showModalBottomSheet(
                                        barrierColor: Colors.transparent,
                                        context: context,
                                        builder: (builder) {
                                          return UserInputDialog(
                                            inputFormatters: [
                                              DecimalTextInputFormatter()
                                            ],
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: true),
                                            textProvider: amountText,
                                            label: "amount",
                                            commonTextEditingController:
                                                amountTEC,
                                          );
                                        });
                                  },
                                text: ref.watch(currencyProvider) +
                                    ref.watch(amountText),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.teal,
                                    textStyle: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dashed))),
                            const TextSpan(text: " on "),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    HapticFeedback.lightImpact();
                                    showGeneralDialog(
                                        pageBuilder: (context, anim1, anim2) {
                                          return const Placeholder();
                                        },
                                        context: context,
                                        transitionBuilder:
                                            (context, anim1, anim2, child) {
                                          return Opacity(
                                              opacity: anim1.value,
                                              child: const CategoryList());
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 200));
                                  },
                                text: ref.watch(categoryText) == "Uncategorised"
                                    ? "nothing in particular"
                                    : ref.watch(categoryText).toLowerCase(),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    color: Color(ref.watch(categoryColorInt)),
                                    textStyle: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dashed))),
                            TextSpan(
                                text: ".",
                                style: GoogleFonts.montserrat(
                                  color: Color(ref.watch(categoryColorInt)),
                                )),
                            TextSpan(
                                text: " (",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.purple,
                                )),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    HapticFeedback.lightImpact();
                                    addNoteTEC.clear();
                                    showModalBottomSheet(
                                        barrierColor: Colors.transparent,
                                        context: context,
                                        builder: (builder) {
                                          return UserInputDialog(
                                            keyboardType: TextInputType.text,
                                            textProvider: noteText,
                                            label: "note",
                                            commonTextEditingController:
                                                addNoteTEC,
                                          );
                                        });
                                  },
                                text: ref.watch(noteText) == ""
                                    ? "note"
                                    : ref.watch(noteText),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.purple,
                                    textStyle: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dashed))),
                            TextSpan(
                                text: ")",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.purple,
                                )),
                          ],
                          style: GoogleFonts.montserrat(
                              height: 1.4,
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              Navigator.of(context).pop();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 3.1,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: const Icon(
                                  Icons.close_rounded,
                                  size: 40,
                                  color: Colors.white,
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              try {
                                ref
                                    .read(entryDatabaseProvider.notifier)
                                    .addEntry(
                                        double.parse(ref.read(amountText)),
                                        dateTimeVar,
                                        ref.read(categoryText),
                                        addNoteTEC.text,
                                        true,
                                        ref.read(categoryColorInt),
                                        ref.read(isSavings));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                        'Deducted ${ref.read(currencyProvider)}${ref.read(amountText)} from vault')));
                                Navigator.of(context).pop();
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content: Text(
                                          'Invalid amount',
                                          style: TextStyle(color: Colors.white),
                                        )));
                                Navigator.of(context).pop();
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 3.1,
                                height: 50,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50))),
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 40,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
