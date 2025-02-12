import 'package:doshi/components/is_savings_selector.dart';
import 'package:doshi/components/user_input_dialog.dart';
import 'package:doshi/logic/decimal_text_input_formatter.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AddToVaultDialogBox extends StatelessWidget {
  const AddToVaultDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.5),
      child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: ThisContainerFinal()),
    );
  }
}

class ThisContainerFinal extends StatelessWidget {
  const ThisContainerFinal({super.key});

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

class ThisContainerOfTheDialogBox extends StatefulWidget {
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
  State<ThisContainerOfTheDialogBox> createState() =>
      _ThisContainerOfTheDialogBoxState();
}

class _ThisContainerOfTheDialogBoxState
    extends State<ThisContainerOfTheDialogBox> {
  DateTime dateTimeVar = DateTime.now();
  final amountTEC = TextEditingController();
  final addNoteTEC = TextEditingController();

  @override
  void initState() {
    setState(() {
      amountTEC.text = "500";
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
                              TextSpan(
                                  text: ref.watch(isSavings)
                                      ? "I would like to "
                                      : "I "),
                              TextSpan(
                                text: ref.watch(isSavings) ? "add" : "gained",
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
                                      color: Colors.amber,
                                      textStyle: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationStyle:
                                              TextDecorationStyle.dashed))),
                              const TextSpan(text: " "),
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
                                                child: const IsSavingsDialog());
                                          },
                                          transitionDuration:
                                              const Duration(milliseconds: 200));
                                    },
                                  text: ref.watch(isSavings)
                                      ? "to my savings."
                                      : "in credit",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blueGrey,
                                      textStyle: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationStyle:
                                              TextDecorationStyle.dashed))),
                              TextSpan(
                                  text: ref.watch(isSavings)
                                      ? ""
                                      : DateFormat('dMMMM').format(dateTimeVar) !=
                                              DateFormat('dMMMM')
                                                  .format(DateTime.now())
                                          ? " on "
                                          : " "),
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
                                text:ref.watch(isSavings)
                                      ? ""
                                      : DateFormat('d MMM yy')
                                            .format(DateTime.now()) ==
                                        DateFormat('d MMM yy').format(dateTimeVar)
                                    ? "today"
                                    : DateFormat('d MMM yy').format(dateTimeVar),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.amber,
                                    textStyle: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dashed)),
                              ),
                              TextSpan(
                                  text:ref.watch(isSavings)
                                      ? ""
                                      : ".",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.amber,
                                  )),
                              TextSpan(
                                  text: !ref.watch(isSavings) ? " (" : "",
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
                                  text: !ref.watch(isSavings)
                                      ? ref.watch(noteText) == ""
                                          ? "note"
                                          : ref.watch(noteText)
                                      : "",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.purple,
                                      textStyle: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationStyle:
                                              TextDecorationStyle.dashed))),
                              TextSpan(
                                  text: !ref.watch(isSavings) ? ")" : "",
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
                      const SizedBox(
                        height: 20,
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
                                          "Uncategorised",
                                          ref.read(noteText),
                                          false,
                                          ref.read(categoryColorInt),
                                          ref.read(isSavings),
                                          "Uncategorised",
                                          ref.read(subCategoryColorInt));
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      backgroundColor: Colors.lightGreen,
                                      content: Text(ref.watch(isSavings)
                                          ? 'Added ${ref.read(currencyProvider)}${ref.read(amountText)} to savings'
                                          : 'Added ${ref.read(currencyProvider)}${ref.read(amountText)} to vault')));
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
