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

class EditIncomeDialogBox extends StatelessWidget {
  final Id id;

  const EditIncomeDialogBox({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.5),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: ThisContainerFinal(id: id)),
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
  const ThisContainerOfTheDialogBox({
    super.key,
    required this.id,
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
  DateTime dateTimeVar = DateTime.now();
  final amountTEC = TextEditingController();
  final addNoteTEC = TextEditingController();

  @override
  void initState() {
    setState(() {
      amountTEC.text = ref.read(amountText);
      addNoteTEC.text = ref.read(noteText);
    });
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  color: widget.color),
              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Opacity(
                  opacity: widget.opacity,
                  child: Column(
                    children: [
                      Consumer(builder: (context, ref, child) {
                        return RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(text: "I meant, I "),
                              TextSpan(
                                text: "gained",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.lightGreen,
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
                                      color: Colors.amber,
                                      textStyle: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationStyle:
                                              TextDecorationStyle.dashed))),
                              const TextSpan(text: " in credit"),
                              TextSpan(
                                  text:
                                      DateFormat('dMMMM').format(dateTimeVar) !=
                                              DateFormat('dMMMM')
                                                  .format(DateTime.now())
                                          ? " on "
                                          : " "),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    HapticFeedback.lightImpact();
                                    final DateTime? picked =
                                        await showDatePicker(
                                            initialDate: DateTime.now(),
                                            context: context,
                                            firstDate: DateTime(
                                                DateTime.now().year - 10),
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
                                        DateFormat('d MMM yy')
                                            .format(dateTimeVar)
                                    ? "today"
                                    : DateFormat('d MMM yy')
                                        .format(dateTimeVar),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.amber,
                                    textStyle: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dashed)),
                              ),
                              TextSpan(
                                  text: ".",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.amber,
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
                        );
                      }),
                      const SizedBox(
                        height: 15,
                      ),
                      Consumer(builder: (context, ref, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width / 3.1,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
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
                                          dateTimeVar,
                                          ref.read(isExpense),
                                          ref.read(categoryColorInt),
                                          ref.read(isSavings),
                                          ref.read(subCategoryText),
                                          ref.read(subCategoryColorInt));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.lightGreen,
                                          content: Text('Updated income')));
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.redAccent,
                                          content: Text(
                                            'Invalid amount',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )));
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width / 3.1,
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
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    amountTEC.dispose();
    super.dispose();
  }
}
