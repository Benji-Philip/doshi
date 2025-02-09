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
import 'package:isar/isar.dart';

class EditEntryDialogBox extends ConsumerStatefulWidget {
  final Id id;
  final double amounttext;
  final DateTime datetimeVar;
  final String categorytext;
  final String addnoteText;
  final bool isexpense;
  final int categorycolorInt;

  const EditEntryDialogBox(
      {super.key,
      required this.id,
      required this.addnoteText,
      required this.amounttext,
      required this.categorycolorInt,
      required this.categorytext,
      required this.datetimeVar,
      required this.isexpense});

  @override
  ConsumerState<EditEntryDialogBox> createState() =>
      _AddExpenseDialogBoxState();
}

class _AddExpenseDialogBoxState extends ConsumerState<EditEntryDialogBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.5),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ThisContainerFinal(
            id: widget.id,
          )),
    );
  }
}

class ThisContainerFinal extends StatelessWidget {
  final Id id;
  const ThisContainerFinal({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ThisContainerOfTheDialogBox(
          id: id,
          opacity: 0,
          padBottom: 0,
          padLeft: 8,
          padRight: 0,
          padTop: 8,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        ThisContainerOfTheDialogBox(
          id: id,
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
  final Id id;
  const ThisContainerOfTheDialogBox(
      {super.key,
      required this.padBottom,
      required this.padLeft,
      required this.padRight,
      required this.padTop,
      required this.color,
      required this.opacity,
      required this.id});

  @override
  ConsumerState<ThisContainerOfTheDialogBox> createState() =>
      _ThisContainerOfTheDialogBoxState();
}

class _ThisContainerOfTheDialogBoxState
    extends ConsumerState<ThisContainerOfTheDialogBox> {
  final amountTEC = TextEditingController();
  final addNoteTEC = TextEditingController();
  final categoryTEC = TextEditingController();
  DateTime varDateTime = DateTime.now();

  @override
  void initState() {
    amountTEC.text = ref.read(amountText);
    categoryTEC.text = ref.read(categoryText);
    addNoteTEC.text = ref.read(noteText);
    varDateTime = ref.read(dateTimeVar);
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
                                text: DateFormat('dMMMM').format(varDateTime) !=
                                        DateFormat('dMMMM')
                                            .format(DateTime.now())
                                    ? "I meant, on "
                                    : "I meant, "),
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
                                        picked != ref.read(dateTimeVar)) {
                                      varDateTime = picked;
                                    }
                                  });
                                },
                              text: DateFormat('d MMM yy')
                                          .format(DateTime.now()) ==
                                      DateFormat('d MMM yy').format(varDateTime)
                                  ? "Today"
                                  : DateFormat('d MMM yy').format(varDateTime),
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
                                text: ref.read(currencyProvider) +
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
                                    .editEntry(
                                        widget.id,
                                        ref.read(categoryText),
                                        double.parse(ref.read(amountText)),
                                        addNoteTEC.text,
                                        varDateTime,
                                        true,
                                        ref.read(categoryColorInt),
                                        ref.read(isSavings));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Updated expense')));
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
