import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

class DeleteEntryDialogBox extends ConsumerWidget {
  final Id id;
  const DeleteEntryDialogBox({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 210,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: Theme.of(context).colorScheme.onTertiary),
            ),
            Container(
              height: 200,
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
                  color: Theme.of(context).colorScheme.tertiary),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, bottom: 16),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 80,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Confirm delete?",
                          softWrap: true,
                          style: GoogleFonts.montserrat(
                              fontSize: 56,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary,
                              decorationColor:
                                  Theme.of(context).colorScheme.tertiary),
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
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 4),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
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
                                        decorationColor: Theme.of(context)
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
                                .read(entryDatabaseProvider.notifier)
                                .deleteEntry(id);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 4),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
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
          ],
        ),
      ),
    );
  }
}
