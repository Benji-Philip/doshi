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

class SlidableEntry extends ConsumerStatefulWidget {
  final double spaceFromTop;
  final double width;
  final WidgetRef ref;
  final List<Entry> currentEntries;
  final int index;
  const SlidableEntry({
    super.key,
    required this.currentEntries,
    required this.ref,
    required this.spaceFromTop,
    required this.width,
    required this.index,
  });

  @override
  ConsumerState<SlidableEntry> createState() => _SlidableEntryState();
}

class _SlidableEntryState extends ConsumerState<SlidableEntry>
    with SingleTickerProviderStateMixin {
  late SlidableController _slidableController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _slidableController = SlidableController(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _slidableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: widget.index == 0 ? 0 : 13),
          child: Visibility(
            visible: widget.index == 0
                ? true
                : DateFormat('dMMMM').format(
                            widget.currentEntries[widget.index].dateTime) ==
                        DateFormat('dMMMM').format(
                            widget.currentEntries[widget.index - 1].dateTime)
                    ? false
                    : true,
            child: Padding(
              padding: EdgeInsets.only(
                  top: widget.index == 0 ? 0 : 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
                            width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      DateFormat('EEEE, d MMMM').format(widget
                                  .currentEntries[widget.index].dateTime) ==
                              DateFormat('EEEE, d MMMM')
                                  .format(DateTime.now())
                          ? "Today"
                          : DateFormat('EEEE, d MMMM').format(
                              widget.currentEntries[widget.index].dateTime),
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
                            color: Theme.of(context).colorScheme.tertiary,
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
        Container(
          width: widget.width * 0.86,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Slidable(
            controller: _slidableController,
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
                        transitionBuilder: (context, anim1, anim2, child) {
                          return Opacity(
                              opacity: anim1.value,
                              child: widget.currentEntries.isNotEmpty &&
                                      widget.index <
                                          widget.currentEntries.length
                                  ? DeleteEntryDialogBox(
                                      id: widget
                                          .currentEntries[widget.index].id)
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
                    ref.read(amountText.notifier).update((state) => widget
                        .currentEntries[widget.index].amount
                        .toString());
                    ref.read(dateTimeVar.notifier).update((state) =>
                        widget.currentEntries[widget.index].dateTime);
                    ref.read(categoryText.notifier).update((state) =>
                        widget.currentEntries[widget.index].category ??
                        "Uncategorised");
                    ref.read(noteText.notifier).update((state) =>
                        widget.currentEntries[widget.index].note ?? "");
                    ref.read(isExpense.notifier).update((state) =>
                        widget.currentEntries[widget.index].isExpense);
                    ref.read(categoryColorInt.notifier).update((state) =>
                        widget.currentEntries[widget.index].categoryColor ??
                        Colors.white.value);
                    if (widget.currentEntries[widget.index].isExpense ==
                        true) {
                      ref.read(isExpense.notifier).update((state) => true);
                      showGeneralDialog(
                          pageBuilder: (context, anim1, anim2) {
                            return const Placeholder();
                          },
                          context: context,
                          transitionBuilder: (context, anim1, anim2, child) {
                            return Opacity(
                                opacity: anim1.value,
                                child: widget.currentEntries.isNotEmpty &&
                                        widget.index <
                                            widget.currentEntries.length
                                    ? EditEntryDialogBox(
                                        id: widget
                                            .currentEntries[widget.index].id,
                                        addnoteText: widget.currentEntries[widget.index].note ??
                                            "",
                                        amounttext: widget
                                            .currentEntries[widget.index]
                                            .amount,
                                        categorycolorInt: widget
                                                .currentEntries[widget.index]
                                                .categoryColor ??
                                            Colors.white.value,
                                        categorytext: widget
                                                .currentEntries[widget.index]
                                                .category ??
                                            "Uncategorised",
                                        datetimeVar: widget
                                            .currentEntries[widget.index]
                                            .dateTime,
                                        isexpense: widget
                                            .currentEntries[widget.index]
                                            .isExpense)
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
                                child: widget.currentEntries.isNotEmpty &&
                                        widget.index <
                                            widget.currentEntries.length
                                    ? EditIncomeDialogBox(
                                        id: widget
                                            .currentEntries[widget.index].id,
                                        addnoteText: widget.currentEntries[widget.index].note ??
                                            "",
                                        amounttext: widget
                                            .currentEntries[widget.index]
                                            .amount,
                                        categorycolorInt: widget
                                                .currentEntries[widget.index]
                                                .categoryColor ??
                                            Colors.white.value,
                                        categorytext: widget
                                                .currentEntries[widget.index]
                                                .category ??
                                            "Uncategorised",
                                        datetimeVar: widget
                                            .currentEntries[widget.index]
                                            .dateTime,
                                        isexpense: widget
                                            .currentEntries[widget.index]
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
            child: GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                  _slidableController.openEndActionPane();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 2),
                              child: Container(
                                width: widget.currentEntries[widget.index]
                                            .note !=
                                        ""
                                    ? 13
                                    : 10,
                                height: widget.currentEntries[widget.index]
                                            .note !=
                                        ""
                                    ? 13
                                    : 10,
                                decoration: BoxDecoration(
                                    color: widget.currentEntries[widget.index]
                                                .isExpense ==
                                            false
                                        ? Colors.lightGreen
                                        : Color(widget
                                                .currentEntries[widget.index]
                                                .categoryColor ??
                                            Colors.white.value),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: SizedBox(
                                    child: Text(
                                      widget.currentEntries[widget.index]
                                                  .category ==
                                              "Uncategorised"
                                          ? widget
                                                  .currentEntries[
                                                      widget.index]
                                                  .isExpense
                                              ? 'Expense'
                                              : 'Income'
                                          : widget
                                                  .currentEntries[
                                                      widget.index]
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
                                  visible: widget.currentEntries[widget.index]
                                              .note !=
                                          ""
                                      ? true
                                      : false,
                                  child: SizedBox(
                                    width: widget.width * 0.44,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        widget.currentEntries[widget.index]
                                                .note ??
                                            '',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.5),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
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
                            widget.currentEntries[widget.index].isExpense
                                ? "-${ref.watch(currencyProvider)}${widget.currentEntries[widget.index].amount}"
                                : "+${ref.watch(currencyProvider)}${widget.currentEntries[widget.index].amount}",
                            softWrap: true,
                            style: GoogleFonts.montserrat(
                                color: widget.currentEntries[widget.index]
                                        .isExpense
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
    );
  }
}
