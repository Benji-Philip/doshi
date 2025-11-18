import 'package:doshi/components/category_list.dart';
import 'package:doshi/components/my_button.dart';
import 'package:doshi/isar/category_entry.dart';
import 'package:doshi/isar/subcategory_entry.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryListSelector extends ConsumerStatefulWidget {
  final bool? editMode;
  const CategoryListSelector({super.key, this.editMode});

  @override
  ConsumerState<CategoryListSelector> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<CategoryListSelector> {
  final _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final categoriesDatabaseProvider = ref.watch(categoryDatabaseProvider);
    final categoriesDatabaseNotifier =
        ref.watch(categoryDatabaseProvider.notifier);
    List<CategoryEntry> currentCategories =
        categoriesDatabaseNotifier.currentCategories.reversed.toList();
    // ignore: unused_local_variable
    final subCategoriesDatabaseProvider =
        ref.watch(subCategoryDatabaseProvider);
    final subCategoriesDatabaseNotifier =
        ref.watch(subCategoryDatabaseProvider.notifier);
    List<SubCategoryEntry> currentSubCategories =
        subCategoriesDatabaseNotifier.currentSubCategories.reversed.toList();
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: Theme.of(context).colorScheme.tertiary),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 21.0,
                      vertical: widget.editMode ?? false ? 0 : 12),
                  child: CategoryList(
                      editMode: widget.editMode,
                      currentCategories: currentCategories,
                      currentSubCategories: currentSubCategories),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: MyButton(
                borderRadius: 50,
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).pop();
                },
                width: 50,
                height: 50,
                iconSize: 32,
                myIcon: Icons.close_rounded,
                iconColor: Colors.white,
                buttonColor: Colors.redAccent,
                splashColor: Colors.red.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
