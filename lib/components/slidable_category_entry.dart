import 'package:doshi/components/add_category_dialogbox.dart';
import 'package:doshi/components/delete_category_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

class SlidableCategoryEntry extends ConsumerStatefulWidget {
  final String category;
  final Id id;
  final int currentCategories;
  final int index;
  const SlidableCategoryEntry(
      {super.key, required this.currentCategories, required this.index, required this.id, required this.category});

  @override
  ConsumerState<SlidableCategoryEntry> createState() =>
      _SlidableCategoryEntryState();
}

class _SlidableCategoryEntryState extends ConsumerState<SlidableCategoryEntry>
    with SingleTickerProviderStateMixin {
  late SlidableController _slidableController;

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
    return GestureDetector(
      onTap: () {
        if (widget.index == widget.currentCategories) {
          HapticFeedback.lightImpact();
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              barrierDismissible: false,
              pageBuilder: (BuildContext context, _, __) {
                return const AddCategory();
              }));
        } else {
          _slidableController.openEndActionPane();
          HapticFeedback.lightImpact();
        }
      },
      child: Slidable(
        controller: _slidableController,
        enabled: widget.index == widget.currentCategories ? false : true,
        endActionPane: ActionPane(
            extentRatio: 0.3,
            motion: const BehindMotion(),
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
                            child: DeleteCategoryDialogBox(
                                id: widget.id));
                      },
                      transitionDuration: const Duration(milliseconds: 200));
                },
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                icon: Icons.delete_rounded,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, right: 4),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: widget.index == widget.currentCategories
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onTertiary,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                    width: 5,
                    color: widget.index == widget.currentCategories
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onTertiary)),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.category,
                softWrap: true,
                style: GoogleFonts.montserrat(
                    color: widget.index == widget.currentCategories
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
