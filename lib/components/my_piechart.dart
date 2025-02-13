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
  final List<Entry> entriesOfGivenMonth;
  final double width;
  final List<SubCategoryAnalysisEntry>? analysisBySubCats;
  const MyPieChart({
    super.key,
    this.isDialogBox,
    required this.width,
    this.analysisBySubCats,
    required this.entriesOfGivenMonth,
    required this.useSubCat,
    this.parentCategory,
    required this.includeUncat,
  });

  @override
  ConsumerState<MyPieChart> createState() => _MyPieChart();
}

class _MyPieChart extends ConsumerState<MyPieChart> {
  List pieChartData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useSubCat) {
      List<SubCategoryAnalysisEntry> temp = widget.analysisBySubCats ??
          sortIntoSubCategories(widget.entriesOfGivenMonth);
      List<SubCategoryAnalysisEntry> temp2 = [];
      if (!widget.includeUncat) {
        for (var i = 0; i < temp.length; i++) {
          if (temp[i].subCategoryName == "Uncategorised" ||
              temp[i].subCategoryName == null) {
          } else {
            temp2.add(temp[i]);
          }
        }
        pieChartData = temp2;
      } else {
        pieChartData = temp;
      }
    } else {
      pieChartData = sortIntoCategories(widget.entriesOfGivenMonth);
    }
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
                            decorationColor:
                                const Color.fromARGB(0, 255, 255, 255),
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                        title: "$sumPercent%",
                        value: double.parse(sumPercent),
                        color: Color(color ?? Colors.white.value));
                  }))),
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
                      // ignore: prefer_if_null_operators
                      : pieChartData[index].subCategoryName;
                  double sum = !widget.useSubCat
                      ? pieChartData[index].categorySum
                      : pieChartData[index].subCategorySum;
                  int? color = !widget.useSubCat
                      ? pieChartData[index].categoryColor
                      : pieChartData[index].subCategoryColor;
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!widget.useSubCat && name != "Uncategorised") {
                            HapticFeedback.lightImpact();
                            Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                barrierDismissible: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return SubCatPieChartDialog(
                                      entriesOfGivenMonth:
                                          widget.entriesOfGivenMonth,
                                      parentCategory: name ?? "Uncategorised",
                                      analysisBySubCats:
                                          widget.analysisBySubCats,
                                      width: widget.width);
                                }));
                          } else {
                            HapticFeedback.lightImpact();
                            if (widget.isDialogBox ?? false) {
                              Navigator.of(context).pop();
                            }
                            ref.read(entriesForSubCatDialog.notifier).update(
                                (state) =>
                                    name == null || name == "Uncategorised"
                                        ? sortEntriesByDate(
                                            widget.entriesOfGivenMonth)
                                        : sortEntrysBySubCategory(
                                            name, widget.entriesOfGivenMonth));
                            Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                barrierDismissible: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return const EntrysInSubCatDialog();
                                }));
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 6),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 55,
                                  width: widget.width * 0.85,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        width: 5),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4,
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
                                                      child: Text(
                                                        name ??
                                                            "no subcategory",
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts
                                                            .montserrat(
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
}
