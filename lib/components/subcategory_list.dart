import 'package:doshi/components/add_subcategory_dialogbox.dart';
import 'package:doshi/components/slidable_subcategory.dart';
import 'package:doshi/isar/subcategory_entry.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubCategoryList extends ConsumerWidget {
  final bool editMode;
  final String currentParentCategory;
  final int currentParentCategoryColor;
  final List<SubCategoryEntry> currentSubCategories;
  const SubCategoryList({
    super.key,
    required this.currentSubCategories,
    required this.currentParentCategory,
    required this.currentParentCategoryColor,
    required this.editMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
        child: Column(children: [
          ...List.generate(currentSubCategories.length + 1, (index) {
            return index < currentSubCategories.length
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (!editMode) {
                          HapticFeedback.lightImpact();
                          ref
                              .read(categoryText.notifier)
                              .update((state) => currentParentCategory);
                          ref
                              .read(categoryColorInt.notifier)
                              .update((state) => currentParentCategoryColor);
                          ref.read(subCategoryText.notifier).update((state) =>
                              currentSubCategories[index].subCategory);
                          ref.read(subCategoryColorInt.notifier).update(
                              (state) =>
                                  currentSubCategories[index].subCategoryColor);
                          Navigator.of(context).pop();
                        }
                      },
                      child: SlidableSubcategory(
                        editMode: editMode,
                        subCatId: currentSubCategories[index].id,
                        slidableEnabled: true,
                        subCategoryColor:
                            currentSubCategories[index].subCategoryColor,
                        text: currentSubCategories[index].subCategory,
                        bgColor: Theme.of(context).colorScheme.onTertiary,
                        textColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            barrierDismissible: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return AddSubCategory(
                                currentSubCats: currentSubCategories,
                              );
                            }));
                      },
                      child: const SlidableSubcategory(
                        editMode: false,
                        slidableEnabled: false,
                        text: "Add New",
                        bgColor: Colors.amber,
                        textColor: Colors.black,
                      ),
                    ),
                  );
          })
        ]));
  }
}
