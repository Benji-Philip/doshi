import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeleteBudgetDialogBox extends ConsumerWidget {
  final String thisBudgetName;
  final bool isSelected;
  const DeleteBudgetDialogBox({
    super.key,
    required this.thisBudgetName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(35)),
                        color: Theme.of(context).colorScheme.onTertiary),
                    child: Opacity(
                      opacity: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24.0, bottom: 4),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 60,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Are you sure?",
                                    softWrap: true,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 56,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        decorationColor: const Color.fromARGB(
                                            0, 255, 255, 255)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 36.0, bottom: 24),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "This will delete it's entries too!",
                                    softWrap: true,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 54,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        decorationColor: const Color.fromARGB(
                                            0, 255, 255, 255)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 14.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 4),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        height: 80,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "cancel",
                                            softWrap: true,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 56,
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                decorationColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 4),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        height: 80,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "delete",
                                            softWrap: true,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 56,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                decorationColor: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, right: 10),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(35)),
                        color: Theme.of(context).colorScheme.tertiary),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0, top: 16),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 60,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Are you sure?",
                                  softWrap: true,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 56,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      decorationColor: const Color.fromARGB(
                                          0, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 32.0, bottom: 24),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Also deletes it's sub-categories!",
                                  softWrap: true,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 54,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.7),
                                      decorationColor: const Color.fromARGB(
                                          0, 255, 255, 255)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 4),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        height: 80,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "cancel",
                                            softWrap: true,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 56,
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                decorationColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    HapticFeedback.heavyImpact();
                                    ref
                                        .read(budgetDatabaseProvider.notifier)
                                        .deleteBudget(
                                            ref, thisBudgetName, isSelected);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 4),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        height: 80,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            "delete",
                                            softWrap: true,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 56,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                decorationColor: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
