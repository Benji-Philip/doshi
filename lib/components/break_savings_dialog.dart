import 'package:doshi/components/user_input_dialog.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BreakSavingsDialog extends ConsumerStatefulWidget {
  const BreakSavingsDialog({super.key});

  @override
  ConsumerState<BreakSavingsDialog> createState() => _BreakSavingsDialogState();
}

class _BreakSavingsDialogState extends ConsumerState<BreakSavingsDialog> {
  final amountTEC = TextEditingController();
  @override
  void initState() {
    super.initState();

    amountTEC.text =
        ref.read(entryDatabaseProvider.notifier).amountInSavings.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 260,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: Theme.of(context).colorScheme.tertiary),
            ),
            Container(
              height: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: Theme.of(context).colorScheme.onSecondary),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            children: [
                              const TextSpan(text: "Replenish credit with "),
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
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              textProvider: amountText,
                                              label: "amount",
                                              commonTextEditingController:
                                                  amountTEC,
                                            );
                                          });
                                    },
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.lightGreen,
                                      textStyle: const TextStyle(
                                          color: Colors.lightGreen,
                                          decoration: TextDecoration.underline,
                                          decorationStyle:
                                              TextDecorationStyle.dotted)),
                                  text:
                                      "${ref.read(currencyProvider)}${ref.read(amountText)}"),
                              const TextSpan(text: " ?")
                            ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30, bottom: 14),
                    child: Visibility(
                      visible: ref.watch(exceedSavings),
                      child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              "Insufficient savings!",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  decorationColor: Colors.redAccent),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            if (double.parse(ref.read(amountText)) >
                                ref
                                    .read(entryDatabaseProvider.notifier)
                                    .amountInSavings) {
                              ref
                                  .read(exceedSavings.notifier)
                                  .update((state) => true);
                            } else {
                              ref
                                  .read(entryDatabaseProvider.notifier)
                                  .breakSavings(ref);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 3.1,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50))),
                              child: Icon(
                                Icons.check_rounded,
                                size: 40,
                                color: Theme.of(context).colorScheme.onPrimary,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
