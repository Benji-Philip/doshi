import 'package:doshi/components/my_button.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IsSavingsDialog extends ConsumerStatefulWidget {
  const IsSavingsDialog({super.key});

  @override
  ConsumerState<IsSavingsDialog> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<IsSavingsDialog> {
  double scrollOffset = 0.0;
  final _listViewScrollController = ScrollController();
  @override
  void dispose() {
    _listViewScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: Theme.of(context).colorScheme.tertiary),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          ref.read(isSavings.notifier).update((state) => false);
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "in credit",
                            softWrap: true,
                            style: GoogleFonts.montserrat(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dotted),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          ref.read(isSavings.notifier).update((state) => true);
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "to savings",
                            softWrap: true,
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dotted,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: MyButton(
                          borderRadius: 50,
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Navigator.of(context).pop();
                          },
                          width: 50,
                          height: 50,
                          iconSize: 32,
                          myIcon: Icons.close_rounded,
                          iconColor: Colors.white,
                          buttonColor: Colors.redAccent,
                          splashColor: Colors.red.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
