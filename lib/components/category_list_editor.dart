import 'package:doshi/components/my_button.dart';
import 'package:doshi/components/slidable_category_entry.dart';
import 'package:doshi/isar/category_entry.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

class CategoryListEditor extends ConsumerStatefulWidget {
  const CategoryListEditor({super.key});

  @override
  ConsumerState<CategoryListEditor> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<CategoryListEditor> {
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
        categoriesDatabaseNotifier.currentCategories.reversed.toList();
    return SafeArea(
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      color: Theme.of(context).colorScheme.tertiary),
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
                            maxScrollExtent = _listViewScrollController
                                .position.maxScrollExtent;
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
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Visibility(
                                  visible: index == currentCategories.length
                                      ? false
                                      : true,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 4),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .delete_forever_rounded,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .surface,
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
                                SlidableCategoryEntry(
                                    id: index == currentCategories.length
                                        ? Id.parse("-1")
                                        : currentCategories[index].id,
                                    category: index == currentCategories.length
                                        ? "Add new"
                                        : currentCategories[index].category,
                                    currentCategories: currentCategories.length,
                                    index: index)
                              ],
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
                                Theme.of(context).colorScheme.tertiary,
                                Colors.transparent
                              ]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                        ),
                        height: 210,
                        width: double.infinity,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
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
