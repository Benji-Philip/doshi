import 'package:doshi/components/add_category_dialogbox.dart';
import 'package:doshi/isar/category_entry.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryList extends ConsumerStatefulWidget {
  const CategoryList({super.key});

  @override
  ConsumerState<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<CategoryList> {
  double scrollOffset = 0.0;
  double maxScrollExtent = 1.0;
  final _listViewScrollController = ScrollController();
  @override
  void dispose() {
    _listViewScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final categoriesDatabaseProvider = ref.watch(categoryDatabaseProvider);
    final categoriesDatabaseNotifier =
        ref.watch(categoryDatabaseProvider.notifier);
    List<CategoryEntry> currentCategories =
        categoriesDatabaseNotifier.currentCategories;
    return SafeArea(
      child: Dialog(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: Theme.of(context).colorScheme.onSecondary),
              child: Padding(
                padding: const EdgeInsets.all(21.0),
                child: NotificationListener(
                  onNotification: (notif) {
                    if (notif is ScrollUpdateNotification) {
                      if (notif.scrollDelta == null) {
                        return false;
                      }
                      setState(() {
                        scrollOffset = _listViewScrollController.offset;
                        maxScrollExtent =
                            _listViewScrollController.position.maxScrollExtent;
                      });
                    }
                    return true;
                  },
                  child: ListView.builder(
                    controller: _listViewScrollController,
                    itemCount: currentCategories.length + 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: GestureDetector(
                          onTap: () {
                            if (index == currentCategories.length) {
                              HapticFeedback.lightImpact();
                              Navigator.of(context).push(PageRouteBuilder(
                                  opaque: false,
                                  barrierDismissible: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return const AddCategory();
                                  }));
                            } else {
                              HapticFeedback.lightImpact();
                              ref.read(categoryText.notifier).update(
                                  (state) => currentCategories[index].category);
                              ref.read(categoryColorInt.notifier).update(
                                  (state) =>
                                      currentCategories[index].categoryColor);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Visibility(
                                visible: index == currentCategories.length
                                    ? false
                                    : true,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10.0, left: 4),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        color: Color(
                                            index == currentCategories.length
                                                ? Colors.white.value
                                                : currentCategories[index]
                                                    .categoryColor)),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.delete_forever_rounded,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            index == currentCategories.length
                                                ? "+"
                                                : currentCategories[index]
                                                    .category,
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
                              Slidable(
                                enabled: index == currentCategories.length
                                    ? false
                                    : true,
                                endActionPane: ActionPane(
                                    extentRatio: 0.3,
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          HapticFeedback.heavyImpact();
                                          categoriesDatabaseNotifier
                                              .deleteCategory(
                                                  currentCategories[index].id);
                                        },
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.transparent,
                                        icon: Icons.delete_rounded,
                                      )
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, right: 4),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                        color: index == currentCategories.length
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        border: Border.all(
                                            width: 5,
                                            color: index ==
                                                    currentCategories.length
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary)),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        index == currentCategories.length
                                            ? "Add new"
                                            : currentCategories[index].category,
                                        softWrap: true,
                                        style: GoogleFonts.montserrat(
                                            color: index ==
                                                    currentCategories.length
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .background
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: true,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: scrollOffset != maxScrollExtent ? 1 : 0,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Theme.of(context).colorScheme.onSecondary,
                            Colors.transparent
                          ]),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    height: 210,
                    width: double.infinity,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
