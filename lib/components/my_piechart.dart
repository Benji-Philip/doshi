import 'package:doshi/components/entrys_in_subcat_dialog.dart';
import 'package:doshi/components/subcat_piechart_dialog.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/logic/sort_entries.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyPieChart extends ConsumerStatefulWidget {
  final bool includeUncat;
  final bool? isDialogBox;
  final String? parentCategory;
  final bool useSubCat;
  final double width;
  final List<SubCategoryAnalysisEntry>? analysisBySubCats;
  const MyPieChart({
    super.key,
    this.isDialogBox,
    required this.width,
    this.analysisBySubCats,
    required this.useSubCat,
    this.parentCategory,
    required this.includeUncat,
  });

  @override
  ConsumerState<MyPieChart> createState() => _MyPieChart();
}

class _MyPieChart extends ConsumerState<MyPieChart> {
  List<SubCategoryAnalysisEntry> subCatAnalysis = [];
  List pieChartData = [];
  List<Entry> entriesOfGivenMonth = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    entriesOfGivenMonth = sortExpensesByGivenMonth(
        ref.read(entryDatabaseProvider.notifier).theListOfTheExpenses,
        ref.read(dateToDisplay));
    if (widget.isDialogBox ?? false) {
      subCatAnalysis = sortIntoSubCategories(sortEntrysByParentCategory(
          widget.parentCategory!, ref.read(entriesGivenMonth)));
    }
    _updatePieChartData();
  }

  void _updatePieChartData() {
    if (widget.useSubCat) {
      List<SubCategoryAnalysisEntry> temp = subCatAnalysis.isEmpty
          ? sortIntoSubCategories(entriesOfGivenMonth)
          : subCatAnalysis;
      pieChartData = widget.includeUncat
          ? temp
          : temp.where((entry) => entry.subCategoryName != "Uncategorised" && entry.subCategoryName != null).toList();
    } else {
      pieChartData = sortIntoCategories(entriesOfGivenMonth);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(entryDatabaseProvider, (prev, next) {
      _initializeData();
    });

    ref.listen(entriesGivenMonth, (prev, next) {
      if (widget.isDialogBox ?? false) {
        pieChartData = sortIntoSubCategories(sortEntrysByParentCategory(widget.parentCategory!, next));
      }
    });

    ref.listen(dateToDisplay, (prev, next) {
      entriesOfGivenMonth = sortExpensesByGivenMonth(ref.read(entryDatabaseProvider.notifier).theListOfTheExpenses, next);
      _updatePieChartData();
    });

    return Column(
      children: [
        Visibility(
          visible: pieChartData.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(top: 38.0, bottom: 15),
            child: SizedBox(
              height: widget.width / 2,
              child: PieChart(
                swapAnimationDuration: const Duration(milliseconds: 750),
                swapAnimationCurve: Curves.easeInOut,
                PieChartData(
                  sections: List.generate(pieChartData.length, (index) {
                    final data = pieChartData[index];
                    final sumPercent = widget.useSubCat ? data.subCategorySumPercent : data.categorySumPercent;
                    final color = widget.useSubCat ? data.subCategoryColor : data.categoryColor;
                    return PieChartSectionData(
                      titlePositionPercentageOffset: 1.6,
                      titleStyle: GoogleFonts.montserrat(
                        decorationColor: const Color.fromARGB(0, 255, 255, 255),
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                      title: "$sumPercent%",
                      value: double.parse(sumPercent),
                      color: Color(color ?? Colors.white.value),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: pieChartData.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 21.0),
            child: Column(
              children: List.generate(pieChartData.length, (index) {
                final data = pieChartData[index];
                final name = widget.useSubCat ? data.subCategoryName : data.categoryName;
                final sum = widget.useSubCat ? data.subCategorySum : data.categorySum;
                final color = widget.useSubCat ? data.subCategoryColor : data.categoryColor;
                final sumPercent = widget.useSubCat ? data.subCategorySumPercent : data.categorySumPercent;

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => _handleTap(context, name, sum, color),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 6, left: 6, right: 6),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: widget.width * 0.8,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).colorScheme.onTertiary, width: 5),
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 21.0, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                height: 12,
                                                width: 12,
                                                decoration: BoxDecoration(
                                                  color: Color(color ?? Colors.white.value),
                                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 4.0),
                                                  child: SizedBox(
                                                    width: widget.width / 2.3,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          name ?? "no subcategory",
                                                          softWrap: true,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: GoogleFonts.montserrat(
                                                            decorationColor: const Color.fromARGB(0, 255, 255, 255),
                                                            color: Theme.of(context).colorScheme.primary,
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                        Text(
                                                          "($sumPercent%)",
                                                          softWrap: true,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: GoogleFonts.montserrat(
                                                            decorationColor: const Color.fromARGB(0, 255, 255, 255),
                                                            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        flex: 1,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            ref.read(currencyProvider) + sum.toStringAsFixed(2),
                                            softWrap: true,
                                            style: GoogleFonts.montserrat(
                                              decorationColor: const Color.fromARGB(0, 255, 255, 255),
                                              color: Color(color ?? Colors.white.value),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        Visibility(
          visible: pieChartData.isEmpty,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '( Nothing added )',
              style: GoogleFonts.montserrat(
                decorationColor: const Color.fromARGB(0, 255, 255, 255),
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleTap(BuildContext context, String? name, double sum, int? color) {
    if (!widget.useSubCat && name != "Uncategorised") {
      HapticFeedback.lightImpact();
      ref.read(entriesGivenMonth.notifier).update((state) => entriesOfGivenMonth);
      Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        barrierDismissible: false,
        pageBuilder: (BuildContext context, _, __) {
          return SubCatPieChartDialog(parentCategory: name ?? "Uncategorised", width: widget.width);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 200),
      ));
    } else {
      HapticFeedback.lightImpact();
      ref.read(entriesForSubCatDialog.notifier).update((state) => widget.useSubCat
          ? name == null || name == "Uncategorised"
              ? name == null
                  ? sortEntrysByParentCategoryAndNullSubCategory(widget.parentCategory ?? "Uncategorised", entriesOfGivenMonth)
                  : sortEntrysByParentCategoryAndSubCategory(widget.parentCategory ?? "Uncategorised", entriesOfGivenMonth)
              : sortEntrysBySubCategory(name, entriesOfGivenMonth)
          : sortEntriesByDate(sortEntrysByParentCategory("Uncategorised", entriesOfGivenMonth)));
      Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        barrierDismissible: false,
        pageBuilder: (BuildContext context, _, __) {
          return EntrysInSubCatDialog(analysisDialogBox: widget.isDialogBox ?? false, useColorChange: true);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 200),
      ));
    }
  }
}
