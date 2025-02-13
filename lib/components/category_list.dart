import 'package:doshi/components/add_category_dialogbox.dart';
import 'package:doshi/components/slidable_category.dart';
import 'package:doshi/components/subcategory_list.dart';
import 'package:doshi/isar/category_entry.dart';
import 'package:doshi/isar/subcategory_entry.dart';
import 'package:doshi/logic/sort_entries.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final openSubCats = StateProvider<int>((state) => -1);

class CategoryList extends ConsumerWidget {
  final List<CategoryEntry> currentCategories;
  final List<SubCategoryEntry> currentSubCategories;
  final bool? editMode;
  const CategoryList({
    super.key,
    required this.currentCategories,
    required this.currentSubCategories,
    this.editMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child) {
      // ignore: unused_local_variable
      final watchSubCatStateUpdate = ref.watch(openSubCats);
      return ListView.builder(
        itemCount: currentCategories.length + 2,
        itemBuilder: (context, index) {
          bool notInList = index >= currentCategories.length;
          bool openSubCat = !notInList && ref.read(openSubCats) == index;
          return Flex(
            direction: Axis.vertical,
            children: [
              Visibility(
                visible: openSubCat,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        ref.read(openSubCats.notifier).update((state) => -1);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            color: Colors.redAccent),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.close_rounded,
                            size: 21,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 13.0,
                    right: 13,
                    bottom: 13,
                    top: openSubCat ? 0 : 13),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(28)),
                      border: openSubCat
                          ? Border.all(
                              width: 3,
                              color: index >= currentCategories.length
                                  ? Theme.of(context).colorScheme.primary
                                  : Color(
                                      currentCategories[index].categoryColor),
                            )
                          : Border.all(color: Colors.transparent)),
                  child: Padding(
                    padding: openSubCat
                        ? const EdgeInsets.all(13.0)
                        : const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (notInList) {
                              HapticFeedback.lightImpact();
                              Navigator.of(context).push(PageRouteBuilder(
                                  opaque: false,
                                  barrierDismissible: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return const AddCategory();
                                  }));
                            } else if (currentCategories[index].category ==
                                "Uncategorised") {
                              HapticFeedback.lightImpact();
                              ref.read(categoryText.notifier).update(
                                  (state) => currentCategories[index].category);
                              ref.read(categoryColorInt.notifier).update(
                                  (state) =>
                                      currentCategories[index].categoryColor);
                              Navigator.of(context).pop();
                            } else if (openSubCat) {
                              HapticFeedback.lightImpact();
                              ref.read(categoryText.notifier).update(
                                  (state) => currentCategories[index].category);
                              ref.read(categoryColorInt.notifier).update(
                                  (state) =>
                                      currentCategories[index].categoryColor);
                              ref
                                  .read(subCategoryText.notifier)
                                  .update((state) => "Uncategorised");
                              ref
                                  .read(subCategoryColorInt.notifier)
                                  .update((state) => Colors.white.value);
                              Navigator.of(context).pop();
                            } else if (!notInList) {
                              HapticFeedback.heavyImpact();
                              ref.read(categoryText.notifier).update(
                                  (state) => currentCategories[index].category);
                              ref
                                  .read(openSubCats.notifier)
                                  .update((state) => index);
                            }
                          },
                          child: SlidableCategory(
                              editMode: editMode ?? false,
                              currentSubCategories: currentSubCategories,
                              openSubCat: openSubCat,
                              notInList: notInList,
                              currentCategories: currentCategories,
                              index: index),
                        ),
                        openSubCat
                            ? SubCategoryList(
                                editMode: editMode ?? false,
                                currentParentCategory:
                                    currentCategories[index].category,
                                currentParentCategoryColor:
                                    currentCategories[index].categoryColor,
                                currentSubCategories: sortSubCategoriesByParent(
                                    currentCategories[index].category,
                                    currentSubCategories))
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
