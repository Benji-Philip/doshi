import 'package:doshi/components/delete_budget_confirm_dialog.dart';
import 'package:doshi/components/edit_budget_dialogbox.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

class SlidableBudget extends ConsumerStatefulWidget {
  final Id id;
  final bool isSelected;
  final String thisBudgetName;
  const SlidableBudget({
    super.key,
    required this.isSelected,
    required this.thisBudgetName,
    required this.id,
  });

  @override
  ConsumerState<SlidableBudget> createState() => _SlidableBudgetState();
}

class _SlidableBudgetState extends ConsumerState<SlidableBudget>
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
    return Slidable(
      controller: _slidableController,
      startActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            padding: const EdgeInsets.all(0),
            onPressed: (context) {
              HapticFeedback.heavyImpact();
              ref
                  .read(editBudgetText.notifier)
                  .update((state) => widget.thisBudgetName);
              showGeneralDialog(
                  pageBuilder: (context, anim1, anim2) {
                    return const Placeholder();
                  },
                  context: context,
                  transitionBuilder: (context, anim1, anim2, child) {
                    return EditBudget(
                      thisBudgetName: widget.thisBudgetName,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 200));
            },
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit_rounded,
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            padding: const EdgeInsets.all(0),
            onPressed: (context) async {
              HapticFeedback.heavyImpact();
              showGeneralDialog(
                  pageBuilder: (context, anim1, anim2) {
                    return const Placeholder();
                  },
                  context: context,
                  transitionBuilder: (context, anim1, anim2, child) {
                    return DeleteBudgetDialogBox(
                        thisBudgetName: widget.thisBudgetName,
                        isSelected: widget.isSelected);
                  },
                  transitionDuration: const Duration(milliseconds: 200));
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete_rounded,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.heavyImpact();
          if (!widget.isSelected) {
            ref
                .read(budgetDatabaseProvider.notifier)
                .selectBudget(ref, widget.id);
            Navigator.of(context).pop();
          } else {
            if (openEnd) {
              _slidableController.openStartActionPane();
              openEnd = false;
            } else {
              _slidableController.openEndActionPane();
              openEnd = true;
            }
          }
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: widget.isSelected
                  ? Colors.amber
                  : Theme.of(context).colorScheme.onTertiary),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                widget.thisBudgetName,
                softWrap: true,
                style: GoogleFonts.montserrat(
                    color: widget.isSelected
                        ? Colors.black
                        : Theme.of(context).colorScheme.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
