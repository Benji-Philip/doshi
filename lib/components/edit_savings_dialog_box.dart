import 'package:doshi/components/user_input_dialog.dart';
import 'package:doshi/logic/decimal_text_input_formatter.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditSavingsDialogBox extends StatelessWidget {
  const EditSavingsDialogBox({super.key});

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
  DateTime dateTimeVar = DateTime.now();
  final amountTEC = TextEditingController();
  final addNoteTEC = TextEditingController();

  @override
  void initState() {
    setState(() {
      amountTEC.text = ref.read(amountText);
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
                            const TextSpan(text: "I've "),
                            TextSpan(
                              text: "saved",
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
                                text: ref.watch(currencyProvider) +
                                    ref.watch(amountText),
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.amber,
                                    textStyle: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dashed))),
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
                            onTap: () async {
                              HapticFeedback.lightImpact();
                              try {
                                    await ref
                                        .read(entryDatabaseProvider.notifier)
                                        .editSavings(ref);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.lightGreen,
                                    content: Text(
                                        'Your savings are ${ref.read(currencyProvider)}${ref.read(amountText)}')));
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
    );
  }

  @override
  void dispose() {
    amountTEC.dispose();
    super.dispose();
  }
}
