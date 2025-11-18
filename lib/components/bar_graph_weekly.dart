import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class BarGraph extends ConsumerWidget {
  final Color linearGradColor1;
  final Color linearGradColor2;
  final double mon;
  final double tue;
  final double wed;
  final double thur;
  final double fri;
  final double sat;
  final double sun;
  final double avg;
  final BuildContext context;
  const BarGraph({
    super.key,
    required this.linearGradColor1,
    required this.linearGradColor2,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thur,
    required this.fri,
    required this.sat,
    required this.sun,
    required this.avg,
    required this.context,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List doublesList = [mon, tue, wed, thur, fri, sat, sun];
    double maxDouble = doublesList
        .reduce((value, element) => value > element ? value : element);
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxDouble + maxDouble * 0.1,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
                rod.toY.round().toString() == '0'
                    ? ''
                    : rod.toY.round().toString(),
                GoogleFonts.montserrat(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700));
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    String todaySymbol = "|";
    final style = TextStyle(
      color: linearGradColor1,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = DateFormat('EEEE').format(DateTime.now()) == "Monday"
            ? todaySymbol
            : 'Mon';
        break;
      case 1:
        text = DateFormat('EEEE').format(DateTime.now()) == "Tuesday"
            ? todaySymbol
            : 'Tue';
        break;
      case 2:
        text = DateFormat('EEEE').format(DateTime.now()) == "Wednesday"
            ? todaySymbol
            : 'Wed';
        break;
      case 3:
        text = DateFormat('EEEE').format(DateTime.now()) == "Thursday"
            ? todaySymbol
            : 'Thu';
        break;
      case 4:
        text = DateFormat('EEEE').format(DateTime.now()) == "Friday"
            ? todaySymbol
            : 'Fri';
        break;
      case 5:
        text = DateFormat('EEEE').format(DateTime.now()) == "Saturday"
            ? todaySymbol
            : 'Sat';
        break;
      case 6:
        text = DateFormat('EEEE').format(DateTime.now()) == "Sunday"
            ? todaySymbol
            : 'Sun';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [linearGradColor1, linearGradColor2],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: mon,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: tue,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: wed,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: thur,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: fri,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: sat,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: sun,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
