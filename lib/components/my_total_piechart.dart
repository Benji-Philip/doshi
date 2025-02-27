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

class MyTotalPieChart extends ConsumerStatefulWidget {
  final bool includeUncat;
  final bool? isDialogBox;
  final String? parentCategory;
  final bool useSubCat;
  final double width;
  final List<SubCategoryAnalysisEntry>? analysisBySubCats;
  const MyTotalPieChart({
    super.key,
    this.isDialogBox,
    required this.width,
    this.analysisBySubCats,
    required this.useSubCat,
    this.parentCategory,
    required this.includeUncat,
  });

  @override
  ConsumerState<MyTotalPieChart> createState() => _MyPieChart();
}

class _MyPieChart extends ConsumerState<MyTotalPieChart> {
  List<SubCategoryAnalysisEntry> subCatAnalysis = [];
  List pieChartData = [];
  List<Entry> totalEntries = [];

  @override
  void initState() {
    super.initState();
    totalEntries = ref.read(entryDatabaseProvider.notifier).theListOfTheExpenses;
    if (widget.isDialogBox ?? false) {
      subCatAnalysis = sortIntoSubCategories(sortEntrysByParentCategory(
          widget.parentCategory!, ref.read(entriesGivenMonth)));
    }
    _updatePieChartData();
  }

  void _updatePieChartData() {
    if (widget.useSubCat) {
      List<SubCategoryAnalysisEntry> temp = subCatAnalysis.isEmpty
          ? sortIntoSubCategories(totalEntries)
          : subCatAnalysis;
      if (!widget.includeUncat) {
        pieChartData = temp.where((entry) =>
            entry.subCategoryName != "Uncategorised" &&
            entry.subCategoryName != null).toList();
      } else {
        pieChartData = temp;
      }
    } else {
      pieChartData = sortIntoCategories(totalEntries);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(entryDatabaseProvider, (prev, next) {
    totalEntries = ref.read(entryDatabaseProvider.notifier).theListOfTheExpenses;
    if (widget.isDialogBox ?? false) {
      subCatAnalysis = sortIntoSubCategories(sortEntrysByParentCategory(
          widget.parentCategory!, ref.read(entriesGivenMonth)));
    }
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
                    String sumPercent = !widget.useSubCat
                        ? pieChartData[index].categorySumPercent
                        : pieChartData[index].subCategorySumPercent;
                    int? color = !widget.useSubCat
                        ? pieChartData[index].categoryColor
                        : pieChartData[index].subCategoryColor;
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
              children: List.generate(
                pieChartData.length,
                (index) {
                  String? name = !widget.useSubCat
                      ? pieChartData[index].categoryName
                      : pieChartData[index].subCategoryName;
                  double sum = !widget.useSubCat
                      ? pieChartData[index].categorySum
                      : pieChartData[index].subCategorySum;
                  int? color = !widget.useSubCat
                      ? pieChartData[index].categoryColor
                      : pieChartData[index].subCategoryColor;
                  String sumPercent = !widget.useSubCat
                      ? pieChartData[index].categorySumPercent
                      : pieChartData[index].subCategorySumPercent;
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _handleTap(context, name, sum, color);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 6, left: 6, right: 6),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: widget.width * 0.8,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary,
                                        width: 5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 21.0,
                                        top: 10,
                                        bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  height: 12,
                                                  width: 12,
                                                  decoration: BoxDecoration(
                                                      color: Color(color ??
                                                          Colors.white.value),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                                  Radius.circular(
                                                                      100))),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4.0),
                                                    child: SizedBox(
                                                      width: widget.width / 2.3,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            name ??
                                                                "no subcategory",
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.montserrat(
                                                                decorationColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                        0,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                          Text(
                                                            "($sumPercent%)",
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts.montserrat(
                                                                decorationColor:
                                                                    const Color
                                                                        .fromARGB(
                                                                        0,
                                                                        255,
                                                                        255,
                                                                        255),
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.7),
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
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
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              ref.read(currencyProvider) +
                                                  sum.toStringAsFixed(2),
                                              softWrap: true,
                                              style: GoogleFonts.montserrat(
                                                  decorationColor:
                                                      const Color.fromARGB(
                                                          0, 255, 255, 255),
                                                  color: Color(color ??
                                                      Colors.white.value),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
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
                },
              ),
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
                  color: Theme.of(context).colorScheme.onTertiary),
            ),
          ),
        )
      ],
    );
  }

  void _handleTap(BuildContext context, String? name, double sum, int? color) {
    if (!widget.useSubCat && name != "Uncategorised") {
      HapticFeedback.lightImpact();
      ref.read(totalEntriesProvider.notifier).update((state) => totalEntries);
      Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        barrierDismissible: false,
        pageBuilder: (BuildContext context, _, __) {
          return SubCatPieChartDialog(
              parentCategory: name ?? "Uncategorised", width: widget.width);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ));
    } else {
      HapticFeedback.lightImpact();
      ref.read(entriesForSubCatDialog.notifier).update((state) => widget.useSubCat
          ? name == null || name == "Uncategorised"
              ? name == null
                  ? sortEntrysByParentCategoryAndNullSubCategory(
                      widget.parentCategory ?? "Uncategorised", totalEntries)
                  : sortEntrysByParentCategoryAndSubCategory(
                      widget.parentCategory ?? "Uncategorised", totalEntries)
              : sortEntrysBySubCategory(name, totalEntries)
          : sortEntriesByDate(
              sortEntrysByParentCategory("Uncategorised", totalEntries)));
      Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        barrierDismissible: false,
        pageBuilder: (BuildContext context, _, __) {
          return EntrysInSubCatDialog(
            analysisDialogBox: widget.isDialogBox ?? false,
            useColorChange: true,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ));
    }
  }
}
