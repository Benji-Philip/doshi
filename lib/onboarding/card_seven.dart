import 'package:doshi/components/slidable_entry.dart';
import 'package:doshi/onboarding/add_savings_onboarding.dart';
import 'package:doshi/onboarding/onboardingbutton.dart';
import 'package:doshi/onboarding/slidable_budget_onboarding.dart';
import 'package:doshi/onboarding/slidable_category_onboarding.dart';
import 'package:doshi/onboarding/slidable_entry_onboarding.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class CardSeven extends StatefulWidget {
  const CardSeven({
    super.key,
  });

  @override
  State<CardSeven> createState() => _CardSevenState();
}

class _CardSevenState extends State<CardSeven> {
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
                                "Tap or swipe left to show options 👈",
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
                      const Flexible(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SlidableCategoryOnboarding(),
                            SlidableEntryOnboarding(),
                            SlidableBudgetOnboarding(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ));
  }
}
