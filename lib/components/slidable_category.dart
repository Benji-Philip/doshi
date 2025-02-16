import 'package:doshi/components/category_list.dart';
import 'package:doshi/components/color_picker_dialogbox.dart';
import 'package:doshi/components/delete_category_confirm_dialog.dart';
import 'package:doshi/components/edit_category_dialogbox.dart';
import 'package:doshi/isar/category_entry.dart';
import 'package:doshi/isar/subcategory_entry.dart';
import 'package:doshi/logic/sort_entries.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

class SlidableCategory extends ConsumerStatefulWidget {
  final Id id;
  final bool editMode;
  final List<SubCategoryEntry> currentSubCategories;
  final List<CategoryEntry> currentCategories;
  final int index;
  final bool notInList;
  final bool openSubCat;
  const SlidableCategory(
      {super.key,
      required this.id,
      required this.notInList,
      required this.currentCategories,
      required this.index,
      required this.openSubCat,
      required this.currentSubCategories,
      required this.editMode});

  @override
  ConsumerState<SlidableCategory> createState() => _SlidableCategoryState();
}

class _SlidableCategoryState extends ConsumerState<SlidableCategory>
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
    return Visibility(
      visible: widget.editMode == true && widget.index == 0 ? false : true,
      child: Visibility(
        visible: widget.index <= widget.currentCategories.length,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              visible: widget.notInList ? false : true,
              child: Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: Color(widget.notInList
                          ? Colors.white.value
                          : widget
                              .currentCategories[widget.index].categoryColor)),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Stack(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete_forever_rounded,
                                  color: Color.fromARGB(0, 255, 255, 255),
                                )
                              ],
                            ),
                          ),
                          Text(
                            "+",
                            softWrap: true,
                            style: GoogleFonts.montserrat(
                                color: Colors.transparent,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Slidable(
              controller: _slidableController,
              enabled: widget.index == 0 || widget.notInList ? false : true,
              endActionPane: ActionPane(
                  extentRatio: 0.3,
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                      padding: const EdgeInsets.only(right: 5),
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
                                    id: widget
                                        .currentCategories[widget.index].id,
                                    subCategories: widget.currentSubCategories,
                                  ));
                            },
                            transitionDuration:
                                const Duration(milliseconds: 200));
                      },
                      backgroundColor: Colors.transparent,
                      foregroundColor: Theme.of(context).colorScheme.surface,
                      icon: Icons.delete_rounded,
                    )
                  ]),
              child: IgnorePointer(
                ignoring: ref.read(openSubCats) == widget.index &&
                        widget.editMode == true
                    ? false
                    : true,
                child: GestureDetector(
                  onLongPress: () {
                    if (widget.index == 0 || widget.notInList) {
                      return;
                    }
                    HapticFeedback.lightImpact();
                    ref.read(categoryColor.notifier).update((state) => Color(
                        widget.currentCategories[widget.index].categoryColor));
                    ref.read(categoryText.notifier).update((state) =>
                        widget.currentCategories[widget.index].category);
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        barrierDismissible: false,
                        pageBuilder: (BuildContext context, _, __) {
                          return EditCategory(
                            id: widget.id,
                          );
                        }));
                  },
                  onTap: () {
                    HapticFeedback.lightImpact();
                    if (widget.index == 0 || widget.notInList) {
                      return;
                    }
                    _slidableController.openEndActionPane();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: widget.notInList
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onTertiary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                              width: 5,
                              color: widget.notInList
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onTertiary)),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.notInList
                              ? "Add new"
                              : widget.editMode && !widget.openSubCat
                                  ? '${widget.currentCategories[widget.index].category} (${sortSubCategoriesByParent(widget.currentCategories[widget.index].category, widget.currentSubCategories).length})'
                                  : widget
                                      .currentCategories[widget.index].category,
                          softWrap: true,
                          style: GoogleFonts.montserrat(
                              color: widget.notInList
                                  ? Theme.of(context).colorScheme.surface
                                  : Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
