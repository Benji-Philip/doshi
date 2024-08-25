import 'package:doshi/components/delete_dialog.dart';
import 'package:doshi/components/edit_expense_dialog_box.dart';
import 'package:doshi/components/edit_income_dialog_box.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

List<Widget> historyPage(
  double spaceFromTop,
  double width,
  WidgetRef ref,
  List<Entry> currentEntries,
) {
  return [
    SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 21, bottom: 16.0, right: 21, left: 21),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'History',
                      style: GoogleFonts.montserrat(
                          fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    SliverList.builder(
        itemCount: currentEntries.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: index == 0 ? 0 : 13),
                  child: Visibility(
                    visible: index == 0
                        ? true
                        : DateFormat('dMMMM')
                                    .format(currentEntries[index].dateTime) ==
                                DateFormat('dMMMM')
                                    .format(currentEntries[index - 1].dateTime)
                            ? false
                            : true,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: index == 0 ? 0 : 20, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiary,
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    width: 3),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              DateFormat('EEEE, d MMMM').format(
                                          currentEntries[index].dateTime) ==
                                      DateFormat('EEEE, d MMMM')
                                          .format(DateTime.now())
                                  ? "Today"
                                  : DateFormat('EEEE, d MMMM')
                                      .format(currentEntries[index].dateTime),
                              style: GoogleFonts.montserrat(
                                  fontSize: 21, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiary,
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    width: 3),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    ref.read(amountText.notifier).update(
                        (state) => currentEntries[index].amount.toString());
                    ref
                        .read(dateTimeVar.notifier)
                        .update((state) => currentEntries[index].dateTime);
                    ref.read(categoryText.notifier).update((state) =>
                        currentEntries[index].category ?? "Uncategorised");
                    ref
                        .read(noteText.notifier)
                        .update((state) => currentEntries[index].note ?? "");
                    ref
                        .read(isExpense.notifier)
                        .update((state) => currentEntries[index].isExpense);
                    ref.read(categoryColorInt.notifier).update((state) =>
                        currentEntries[index].categoryColor ??
                        Colors.white.value);
                    if (currentEntries[index].isExpense == true) {
                      ref.read(isExpense.notifier).update((state) => true);
                      showGeneralDialog(
                          pageBuilder: (context, anim1, anim2) {
                            return const Placeholder();
                          },
                          context: context,
                          transitionBuilder: (context, anim1, anim2, child) {
                            return Opacity(
                                opacity: anim1.value,
                                child: currentEntries.isNotEmpty &&
                                        index < currentEntries.length
                                    ? EditEntryDialogBox(
                                        id: currentEntries[index].id,
                                        addnoteText:
                                            currentEntries[index].note ?? "",
                                        amounttext:
                                            currentEntries[index].amount,
                                        categorycolorInt: currentEntries[index]
                                                .categoryColor ??
                                            Colors.white.value,
                                        categorytext:
                                            currentEntries[index].category ??
                                                "Uncategorised",
                                        datetimeVar:
                                            currentEntries[index].dateTime,
                                        isexpense:
                                            currentEntries[index].isExpense)
                                    : const Text(""));
                          },
                          transitionDuration:
                              const Duration(milliseconds: 200));
                    } else {
                      ref.read(isExpense.notifier).update((state) => false);
                      showGeneralDialog(
                          pageBuilder: (context, anim1, anim2) {
                            return const Placeholder();
                          },
                          context: context,
                          transitionBuilder: (context, anim1, anim2, child) {
                            return Opacity(
                                opacity: anim1.value,
                                child: currentEntries.isNotEmpty &&
                                        index < currentEntries.length
                                    ? EditIncomeDialogBox(
                                        id: currentEntries[index].id,
                                        addnoteText:
                                            currentEntries[index].note ?? "",
                                        amounttext:
                                            currentEntries[index].amount,
                                        categorycolorInt: currentEntries[index]
                                                .categoryColor ??
                                            Colors.white.value,
                                        categorytext:
                                            currentEntries[index].category ??
                                                "Uncategorised",
                                        datetimeVar:
                                            currentEntries[index].dateTime,
                                        isexpense:
                                            currentEntries[index].isExpense)
                                    : const Text(""));
                          },
                          transitionDuration:
                              const Duration(milliseconds: 200));
                    }
                  },
                  child: Container(
                    width: width * 0.86,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Slidable(
                      // Specify a key if the Slidable is dismissible.
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              HapticFeedback.heavyImpact();
                              showGeneralDialog(
                                  pageBuilder: (context, anim1, anim2) {
                                    return const Placeholder();
                                  },
                                  context: context,
                                  transitionBuilder:
                                      (context, anim1, anim2, child) {
                                    return Opacity(
                                        opacity: anim1.value,
                                        child: currentEntries.isNotEmpty &&
                                                index < currentEntries.length
                                            ? DeleteEntryDialogBox(
                                                id: currentEntries[index].id)
                                            : const Text(""));
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 200));
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete_rounded,
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              HapticFeedback.heavyImpact();
                              ref.read(amountText.notifier).update((state) =>
                                  currentEntries[index].amount.toString());
                              ref.read(dateTimeVar.notifier).update(
                                  (state) => currentEntries[index].dateTime);
                              ref.read(categoryText.notifier).update((state) =>
                                  currentEntries[index].category ??
                                  "Uncategorised");
                              ref.read(noteText.notifier).update(
                                  (state) => currentEntries[index].note ?? "");
                              ref.read(isExpense.notifier).update(
                                  (state) => currentEntries[index].isExpense);
                              ref.read(categoryColorInt.notifier).update(
                                  (state) =>
                                      currentEntries[index].categoryColor ??
                                      Colors.white.value);
                              if (currentEntries[index].isExpense == true) {
                                ref
                                    .read(isExpense.notifier)
                                    .update((state) => true);
                                showGeneralDialog(
                                    pageBuilder: (context, anim1, anim2) {
                                      return const Placeholder();
                                    },
                                    context: context,
                                    transitionBuilder:
                                        (context, anim1, anim2, child) {
                                      return Opacity(
                                          opacity: anim1.value,
                                          child: currentEntries
                                                      .isNotEmpty &&
                                                  index < currentEntries.length
                                              ? EditEntryDialogBox(
                                                  id: currentEntries[index].id,
                                                  addnoteText:
                                                      currentEntries[index]
                                                              .note ??
                                                          "",
                                                  amounttext:
                                                      currentEntries[index]
                                                          .amount,
                                                  categorycolorInt:
                                                      currentEntries[index]
                                                              .categoryColor ??
                                                          Colors.white.value,
                                                  categorytext:
                                                      currentEntries[index]
                                                              .category ??
                                                          "Uncategorised",
                                                  datetimeVar:
                                                      currentEntries[index]
                                                          .dateTime,
                                                  isexpense: currentEntries[index]
                                                      .isExpense)
                                              : const Text(""));
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 200));
                              } else {
                                ref
                                    .read(isExpense.notifier)
                                    .update((state) => false);
                                showGeneralDialog(
                                    pageBuilder: (context, anim1, anim2) {
                                      return const Placeholder();
                                    },
                                    context: context,
                                    transitionBuilder:
                                        (context, anim1, anim2, child) {
                                      return Opacity(
                                          opacity: anim1.value,
                                          child: currentEntries
                                                      .isNotEmpty &&
                                                  index < currentEntries.length
                                              ? EditIncomeDialogBox(
                                                  id: currentEntries[index].id,
                                                  addnoteText:
                                                      currentEntries[index]
                                                              .note ??
                                                          "",
                                                  amounttext:
                                                      currentEntries[index]
                                                          .amount,
                                                  categorycolorInt:
                                                      currentEntries[index]
                                                              .categoryColor ??
                                                          Colors.white.value,
                                                  categorytext:
                                                      currentEntries[index]
                                                              .category ??
                                                          "Uncategorised",
                                                  datetimeVar:
                                                      currentEntries[index]
                                                          .dateTime,
                                                  isexpense: currentEntries[index]
                                                      .isExpense)
                                              : const Text(""));
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 200));
                              }
                            },
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.edit_rounded,
                          ),
                        ],
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.tertiary,
                              width: 3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 4, right: 21.0, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0, right: 2),
                                      child: Container(
                                        width: currentEntries[index].note != ""
                                            ? 13
                                            : 10,
                                        height: currentEntries[index].note != ""
                                            ? 13
                                            : 10,
                                        decoration: BoxDecoration(
                                            color: currentEntries[index]
                                                        .isExpense ==
                                                    false
                                                ? Colors.lightGreen
                                                : Color(currentEntries[index]
                                                        .categoryColor ??
                                                    Colors.white.value),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(100))),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: SizedBox(
                                            child: Text(
                                              currentEntries[index].category ==
                                                      "Uncategorised"
                                                  ? currentEntries[index]
                                                          .isExpense
                                                      ? 'Expense'
                                                      : 'Income'
                                                  : currentEntries[index]
                                                          .category ??
                                                      '',
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.montserrat(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              currentEntries[index].note != ""
                                                  ? true
                                                  : false,
                                          child: SizedBox(
                                            width: width * 0.44,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                currentEntries[index].note ??
                                                    '',
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.montserrat(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.5),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 1,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    currentEntries[index].isExpense
                                        ? "-${ref.watch(currencyProvider)}${currentEntries[index].amount}"
                                        : "+${ref.watch(currencyProvider)}${currentEntries[index].amount}",
                                    softWrap: true,
                                    style: GoogleFonts.montserrat(
                                        color: currentEntries[index].isExpense
                                            ? Colors.redAccent
                                            : Colors.lightGreen,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
  ];
}
