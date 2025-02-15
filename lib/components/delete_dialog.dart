import 'package:doshi/components/entrys_in_subcat_dialog.dart';
import 'package:doshi/components/subcat_piechart_dialog.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

class DeleteEntryDialogBox extends ConsumerWidget {
  final Id id;
  final bool analysisDialog;
  const DeleteEntryDialogBox({
    super.key,
    required this.id,
    required this.analysisDialog,
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
                                height: 80,
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
                            padding:
                                const EdgeInsets.only(left: 24.0, bottom: 4),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 80,
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
                                        .read(entryDatabaseProvider.notifier)
                                        .deleteEntry(id);
                                    ref
                                        .read(appSettingsDatabaseProvider
                                            .notifier)
                                        .fetchEntries();
                                    ref
                                        .read(entryDatabaseProvider.notifier)
                                        .fetchEntries();
                                    ref
                                        .read(categoryDatabaseProvider.notifier)
                                        .fetchEntries();
                                    ref
                                        .read(subCategoryDatabaseProvider
                                            .notifier)
                                        .fetchEntries();
                                    if (analysisDialog) {
                                      List<Entry> temp3 =
                                          ref.read(entriesGivenMonth);
                                      List<Entry> temp4 =
                                          ref.read(entriesGivenMonth);
                                      List<Entry> temp1 =
                                          ref.read(entriesForSubCatDialog);
                                      List<Entry> temp2 =
                                          ref.read(entriesForSubCatDialog);
                                      for (var i = 0; i < temp2.length; i++) {
                                        if (temp1[i].id == id) {
                                          temp1.removeAt(i);
                                        }
                                      }
                                      for (var i = 0; i < temp4.length; i++) {
                                        if (temp3[i].id == id) {
                                          temp3.removeAt(i);
                                        }
                                      }
                                      ref
                                          .read(entriesForSubCatDialog.notifier)
                                          .state = [...temp1];
                                      ref
                                          .read(entriesGivenMonth.notifier)
                                          .state = [...temp3];
                                      if (temp1.isEmpty) {
                                        Navigator.of(context).pop();
                                      }
                                    }
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
