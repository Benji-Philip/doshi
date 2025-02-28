import 'package:currency_picker/currency_picker.dart';
import 'package:doshi/onboarding/onboardingbutton.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class CardTwo extends StatefulWidget {
  const CardTwo({
    super.key,
  });

  @override
  State<CardTwo> createState() => _CardTwoState();
}

class _CardTwoState extends State<CardTwo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        CardContainer(
          padBottom: 0,
          padLeft: 8,
          padRight: 0,
          padTop: 8,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        CardContainer(
          padBottom: 8,
          padLeft: 0,
          padRight: 8,
          padTop: 0,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ],
    );
  }
}

class CardContainer extends StatefulWidget {
  final double padTop;
  final double padBottom;
  final double padLeft;
  final double padRight;
  final Color color;
  const CardContainer({
    super.key,
    required this.padBottom,
    required this.padLeft,
    required this.padRight,
    required this.padTop,
    required this.color,
  });

  @override
  State<CardContainer> createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            bottom: widget.padBottom,
            right: widget.padRight,
            top: widget.padTop,
            left: widget.padLeft),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
              decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24.0, horizontal: 30),
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 24),
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                "Choose your currency 🪙",
                                overflow: TextOverflow.visible,
                                style: GoogleFonts.montserrat(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Transform.scale(
                            scale: 1.25,
                            child: Lottie.asset('lib/assets/lottie/coin.json', fit: BoxFit.scaleDown , alignment: Alignment.center)),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 36.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onTertiary,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Consumer(builder: (context, ref, child) {
                                return OnboardingButton(
                                    borderRadius: 20,
                                    buttonColor: Colors.amberAccent,
                                    width: 200,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        ref.watch(currencyProvider),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                    ),
                                    onTap: () {
                                      HapticFeedback.heavyImpact();
                                      showCurrencyPicker(
                                        context: context,
                                        showFlag: true,
                                        showCurrencyName: true,
                                        showCurrencyCode: true,
                                        onSelect: (Currency currency) {
                                          HapticFeedback.lightImpact();
                                          ref
                                              .read(appSettingsDatabaseProvider
                                                  .notifier)
                                              .editSetting(3, "CurrencySymbol",
                                                  currency.symbol);
                                          ref
                                              .read(currencyProvider.notifier)
                                              .update(
                                                  (state) => currency.symbol);
                                        },
                                      );
                                    });
                              }),
                            ),
                          )),
                    ],
                  ),
                ),
              )),
        ));
  }
}
