import 'package:doshi/components/my_button.dart';
import 'package:doshi/components/my_piechart.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/logic/sort_entries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubCatPieChartDialog extends StatefulWidget {
  final List<Entry> entriesOfGivenMonth;
  final String parentCategory;
  final double width;
  final List<SubCategoryAnalysisEntry>? analysisBySubCats;
  const SubCatPieChartDialog({
    super.key,
    required this.analysisBySubCats,
    required this.width,
    required this.parentCategory,
    required this.entriesOfGivenMonth,
  });

  @override
  State<SubCatPieChartDialog> createState() => _SubCatPieChartDialogState();
}

class _SubCatPieChartDialogState extends State<SubCatPieChartDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ThisContainer(
                  widget: widget,
                  opacity: 0,
                  padBottom: 0,
                  padLeft: 8,
                  padRight: 0,
                  padTop: 8,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                ThisContainer(
                  widget: widget,
                  opacity: 1,
                  padBottom: 8,
                  padLeft: 0,
                  padRight: 8,
                  padTop: 0,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
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
    );
  }
}

class ThisContainer extends StatelessWidget {
  final double padTop;
  final double padBottom;
  final double padLeft;
  final double padRight;
  final Color color;
  final double opacity;
  const ThisContainer({
    super.key,
    required this.widget,
    required this.padBottom,
    required this.padLeft,
    required this.padRight,
    required this.padTop,
    required this.color,
    required this.opacity,
  });

  final SubCatPieChartDialog widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: padBottom + MediaQuery.of(context).viewInsets.bottom,
          right: padRight,
          top: padTop,
          left: padLeft),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  color: color),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Opacity(
                  opacity: opacity,
                  child: Consumer(builder: (context, ref, child) {
                    return MyPieChart(
                      includeUncat: true,
                      isDialogBox: true,
                      parentCategory: widget.parentCategory,
                      useSubCat: true,
                      entriesOfGivenMonth: sortEntrysByParentCategory(widget.parentCategory, widget.entriesOfGivenMonth),
                      width: widget.width,
                      analysisBySubCats:
                          sortIntoSubCategories(sortEntrysByParentCategory(
                        widget.parentCategory, widget.entriesOfGivenMonth
                      )),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
