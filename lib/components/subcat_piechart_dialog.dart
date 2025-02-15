import 'package:doshi/components/my_button.dart';
import 'package:doshi/components/my_piechart.dart';
import 'package:doshi/isar/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final entriesGivenMonth = StateProvider<List<Entry>>((state) => []);

class SubCatPieChartDialog extends ConsumerStatefulWidget {
  final String parentCategory;
  final double width;
  const SubCatPieChartDialog({
    super.key,
    required this.width,
    required this.parentCategory,
  });

  @override
  ConsumerState<SubCatPieChartDialog> createState() =>
      _SubCatPieChartDialogState();
}

class _SubCatPieChartDialogState extends ConsumerState<SubCatPieChartDialog> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.5),
      child: SingleChildScrollView(
        controller: _scrollController,
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
      ),
    );
  }
}

class ThisContainer extends StatefulWidget {
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
  State<ThisContainer> createState() => _ThisContainerState();
}

class _ThisContainerState extends State<ThisContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.padBottom + MediaQuery.of(context).viewInsets.bottom,
          right: widget.padRight,
          top: widget.padTop,
          left: widget.padLeft),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: widget.color),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Opacity(
                opacity: widget.opacity,
                child: MyPieChart(
                  includeUncat: true,
                  isDialogBox: true,
                  parentCategory: widget.widget.parentCategory,
                  useSubCat: true,
                  width: widget.widget.width,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
