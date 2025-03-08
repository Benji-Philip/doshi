import 'package:doshi/components/color_picker_dialogbox.dart';
import 'package:doshi/components/delete_subcategory_confirm_dialog.dart';
import 'package:doshi/components/edit_subcategory_dialogbox.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

class SlidableSubcategory extends ConsumerStatefulWidget {
  final String parentCategory;
  final bool editMode;
  final Id? subCatId;
  final bool slidableEnabled;
  final int? subCategoryColor;
  final Color? bgColor;
  final Color? textColor;
  final String text;
  const SlidableSubcategory(
      {super.key,
      required this.parentCategory,
      required this.text,
      this.bgColor,
      this.textColor,
      this.subCategoryColor,
      required this.slidableEnabled,
      this.subCatId,
      required this.editMode});

  @override
  ConsumerState<SlidableSubcategory> createState() =>
      _SlidableSubcategoryState();
}

class _SlidableSubcategoryState extends ConsumerState<SlidableSubcategory>
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
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Visibility(
          visible: widget.subCategoryColor == null ? false : true,
          child: Padding(
            padding: const EdgeInsets.only(left: 3, right: 3, top: 3),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Color(widget.subCategoryColor ?? Colors.white.toARGB32())),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.transparent,
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
          enabled: widget.slidableEnabled && widget.editMode ? true : false,
          endActionPane: ActionPane(
              extentRatio: 0.5,
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  onPressed: (context) {
                    HapticFeedback.heavyImpact();
                    if (widget.subCatId != null) {
                      if (widget.subCatId == null) {
                        return;
                      }
                      HapticFeedback.lightImpact();
                      ref.read(categoryColor.notifier).update((state) =>
                          Color(widget.subCategoryColor ?? Colors.white.toARGB32()));
                      ref
                          .read(categoryText.notifier)
                          .update((state) => widget.text);
                      Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          barrierDismissible: false,
                          pageBuilder: (BuildContext context, _, __) {
                            return EditSubCategory(
                                id: widget.subCatId ?? -1,
                                parentCategory: widget.parentCategory);
                          }));
                    }
                  },
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  icon: Icons.edit_rounded,
                ),
                SlidableAction(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  onPressed: (context) {
                    HapticFeedback.heavyImpact();
                    if (widget.subCatId != null) {
                      showGeneralDialog(
                          pageBuilder: (context, anim1, anim2) {
                            return const Placeholder();
                          },
                          context: context,
                          transitionBuilder: (context, anim1, anim2, child) {
                            return Opacity(
                                opacity: anim1.value,
                                child: DeleteSubCategoryDialogBox(
                                    id: widget.subCatId!));
                          },
                          transitionDuration:
                              const Duration(milliseconds: 200));
                    }
                  },
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  icon: Icons.delete_rounded,
                )
              ]),
          child: IgnorePointer(
            ignoring: !widget.editMode,
            child: GestureDetector(
              onLongPress: () {
                if (widget.subCatId == null) {
                  return;
                }
                HapticFeedback.lightImpact();
                ref.read(categoryColor.notifier).update((state) =>
                    Color(widget.subCategoryColor ?? Colors.white.toARGB32()));
                ref.read(categoryText.notifier).update((state) => widget.text);
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    barrierDismissible: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return EditSubCategory(
                          id: widget.subCatId ?? -1,
                          parentCategory: widget.parentCategory);
                    }));
              },
              onTap: () {
                HapticFeedback.lightImpact();
                if (openEnd) {
                  _slidableController.openStartActionPane();
                  openEnd = false;
                } else {
                  _slidableController.openEndActionPane();
                  openEnd = true;
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: widget.bgColor ??
                          Theme.of(context).colorScheme.primary,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.text,
                          overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                          color: widget.textColor ??
                              Theme.of(context).colorScheme.surface,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  )),
            ),
          ),  
        ),
      ],
    );
  }
}
