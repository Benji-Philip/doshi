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
  final bool useColorChange;
  final bool analysisDialog;
  final double spaceFromTop;
  final double width;
  final WidgetRef ref;
  final List<Entry> currentEntries;
  final int index;
  const SlidableEntry({
    super.key,
    required this.currentEntries,
    required this.useColorChange,
    required this.ref,
    required this.spaceFromTop,
    required this.width,
    required this.index,
    required this.analysisDialog,
  });

  @override
  ConsumerState<SlidableEntry> createState() => _SlidableEntryState();
}

class _SlidableEntryState extends ConsumerState<SlidableEntry>
    with SingleTickerProviderStateMixin {
  late SlidableController _slidableController;
  bool openEnd = false;

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController(this);
  }

  @override
  void dispose() {
    _slidableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: widget.index == 0 ? 0 : 0),
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
              padding:
                  EdgeInsets.only(top: widget.index == 0 ? 0 : 0, bottom: 12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    DateFormat('EEEE, d MMMM').format(
                                widget.currentEntries[widget.index].dateTime) ==
                            DateFormat('EEEE, d MMMM').format(DateTime.now())
                        ? "Today"
                        : DateFormat('EEEE, d MMMM').format(
                            widget.currentEntries[widget.index].dateTime),
                    style: GoogleFonts.montserrat(
                        color: Theme.of(context).colorScheme.primary,
                        decorationColor: const Color.fromARGB(0, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            width: widget.width * 0.86,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: widget.useColorChange
                  ? Theme.of(context).colorScheme.onTertiary
                  : Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.all(
                  Radius.circular(widget.useColorChange ? 20 : 15)),
            ),
            child: Slidable(
              controller: _slidableController,
              endActionPane: widget.analysisDialog
                  ? null
                  : ActionPane(
                      extentRatio: 0.5,
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          padding: const EdgeInsets.all(0),
                          onPressed: (context) {
                            editThisEntry(context);
                          },
                          backgroundColor: const Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.edit_rounded,
                        ),
                        SlidableAction(
                          padding: const EdgeInsets.all(0),
                          onPressed: (context) async {
                            await deleteThisEntry(context);
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete_rounded,
                        ),
                      ],
                    ),
              child: GestureDetector(
                onTap: () {
                  if (!widget.analysisDialog) {
                    HapticFeedback.lightImpact();
                    editThisEntry(context);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: widget.useColorChange
                        ? Theme.of(context).colorScheme.onTertiary
                        : Theme.of(context).colorScheme.tertiary,
                    border: Border.all(
                        color: widget.useColorChange
                            ? Theme.of(context).colorScheme.onTertiary
                            : Theme.of(context).colorScheme.tertiary,
                        width: 3),
                    borderRadius: BorderRadius.all(
                        Radius.circular(widget.useColorChange ? 20 : 15)),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                                color: widget
                                                            .currentEntries[
                                                                widget.index]
                                                            .isExpense ==
                                                        false
                                                    ? Colors.lightGreen
                                                    : Color(widget
                                                            .currentEntries[
                                                                widget.index]
                                                            .categoryColor ??
                                                        Colors.white
                                                            .toARGB32()),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(100))),
                                          ),
                                        ),
                                        SizedBox(
                                          width: widget.width / 2.3,
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
                                                decorationColor:
                                                    const Color.fromARGB(
                                                        0, 255, 255, 255),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.currentEntries[widget.index]
                                                .subCategory !=
                                            null &&
                                        widget.currentEntries[widget.index]
                                                .subCategory !=
                                            "Uncategorised",
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 6),
                                          child: Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                                color: Color(widget
                                                        .currentEntries[
                                                            widget.index]
                                                        .subCategoryColor ??
                                                    Colors.white.toARGB32()),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(100))),
                                          ),
                                        ),
                                        SizedBox(
                                          child: Text(
                                            widget.currentEntries[widget.index]
                                                    .isExpense
                                                ? widget
                                                            .currentEntries[
                                                                widget.index]
                                                            .subCategory !=
                                                        "Uncategorised"
                                                    ? widget
                                                            .currentEntries[
                                                                widget.index]
                                                            .subCategory ??
                                                        ''
                                                    : ''
                                                : '',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                decorationColor:
                                                    const Color.fromARGB(
                                                        0, 255, 255, 255),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withAlpha(
                                                        (0.75 * 255).round()),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.currentEntries[widget.index]
                                                .note !=
                                            ""
                                        ? true
                                        : false,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 19.0),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, right: 9),
                                              child: Container(
                                                width: 3,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withAlpha((0.5 * 255)
                                                            .round()),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                              ),
                                            ),
                                            SizedBox(
                                              width: widget.analysisDialog
                                                  ? widget.width * 0.3
                                                  : widget.width * 0.4,
                                              child: Text(
                                                widget
                                                        .currentEntries[
                                                            widget.index]
                                                        .note ??
                                                    '',
                                                softWrap: true,
                                                overflow: widget.analysisDialog
                                                    ? TextOverflow.ellipsis
                                                    : TextOverflow.visible,
                                                style: GoogleFonts.montserrat(
                                                    decorationColor:
                                                        const Color.fromARGB(
                                                            0, 255, 255, 255),
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withAlpha((0.75 * 255)
                                                            .round()),
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
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
                                  decorationColor:
                                      const Color.fromARGB(0, 255, 255, 255),
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
        ),
      ],
    );
  }

  Future<void> deleteThisEntry(BuildContext context) async {
    HapticFeedback.heavyImpact();
    await showGeneralDialog(
        pageBuilder: (context, anim1, anim2) {
          return const Placeholder();
        },
        context: context,
        transitionBuilder: (context, anim1, anim2, child) {
          return Opacity(
              opacity: anim1.value,
              child: widget.currentEntries.isNotEmpty &&
                      widget.index < widget.currentEntries.length
                  ? DeleteEntryDialogBox(
                      useColorChange: widget.useColorChange,
                      analysisDialog: widget.analysisDialog,
                      id: widget.currentEntries[widget.index].id)
                  : const Text(""));
        },
        transitionDuration: const Duration(milliseconds: 200));
  }

  void editThisEntry(BuildContext context) {
    HapticFeedback.heavyImpact();
    ref.read(amountText.notifier).update(
        (state) => widget.currentEntries[widget.index].amount.toString());
    ref
        .read(dateTimeVar.notifier)
        .update((state) => widget.currentEntries[widget.index].dateTime);
    ref.read(categoryText.notifier).update((state) =>
        widget.currentEntries[widget.index].category ?? "Uncategorised");
    ref.read(subCategoryText.notifier).update((state) =>
        widget.currentEntries[widget.index].subCategory ?? "Uncategorised");
    ref
        .read(noteText.notifier)
        .update((state) => widget.currentEntries[widget.index].note ?? "");
    ref
        .read(isExpense.notifier)
        .update((state) => widget.currentEntries[widget.index].isExpense);
    ref.read(categoryColorInt.notifier).update((state) =>
        widget.currentEntries[widget.index].categoryColor ??
        Colors.white.toARGB32());
    ref.read(subCategoryColorInt.notifier).update((state) =>
        widget.currentEntries[widget.index].subCategoryColor ??
        Colors.white.toARGB32());
    if (widget.currentEntries[widget.index].isExpense == true) {
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
                        widget.index < widget.currentEntries.length
                    ? EditEntryDialogBox(
                        useColorChange: widget.useColorChange,
                        analysisDialog: widget.analysisDialog,
                        id: widget.currentEntries[widget.index].id,
                      )
                    : const Text(""));
          },
          transitionDuration: const Duration(milliseconds: 200));
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
                        widget.index < widget.currentEntries.length
                    ? EditIncomeDialogBox(
                        id: widget.currentEntries[widget.index].id,
                      )
                    : const Text(""));
          },
          transitionDuration: const Duration(milliseconds: 200));
    }
  }
}
