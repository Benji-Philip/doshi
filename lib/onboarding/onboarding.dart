// welcome page - start skip onboarding
// show how to add to budget
// show how to add an expense
// show how to add savings
// show how to switch pages
// show how to switch budget profiles
// all done page

// 7 in total

import 'package:doshi/onboarding/card_eight.dart';
import 'package:doshi/onboarding/card_five.dart';
import 'package:doshi/onboarding/card_four.dart';
import 'package:doshi/onboarding/card_one.dart';
import 'package:doshi/onboarding/card_seven.dart';
import 'package:doshi/onboarding/card_six.dart';
import 'package:doshi/onboarding/card_three.dart';
import 'package:doshi/onboarding/card_two.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final endOnBoarding = StateProvider((state) => false);

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).colorScheme.surface.withAlpha((0.8*255).round()),
      child: FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.scaleDown,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 8,
                  child: PageView(
                    controller: _pageController,
                    children: const [
                      CardOne(),
                      CardTwo(),
                      CardThree(),
                      CardFour(),
                      CardFive(),
                      CardSix(),
                      CardSeven(),
                      CardEight(),
                    ],
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: Transform.scale(
                      scale: 0.7,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onTertiary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: 8,
                              effect: WormEffect(
                                  type: WormType.thin,
                                  activeDotColor:
                                      Theme.of(context).colorScheme.primary,
                                  dotColor: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha((0.3*255).round())),
                            ),
                          ),
                        ),
                      ),
                    )),
                Flexible(
                  flex: 1,
                  child: Consumer(builder: (context, ref, child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.heavyImpact();
                          ref
                              .read(appSettingsDatabaseProvider.notifier)
                              .editSetting(7, "EndOnboarding", "true");
                          ref.read(endOnBoarding.notifier).state = true;
                        },
                        child: Text(
                          "skip",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
