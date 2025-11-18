import 'package:doshi/components/slidable_entry.dart';
import 'package:doshi/isar/entry.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<Widget> historyPage(
  double spaceFromTop,
  double width,
  WidgetRef ref,
  List<Entry> currentEntries,
) {
  return [
    SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 21, bottom: 16.0, right: 21, left: 21),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'History',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    SliverList.builder(
        itemCount: currentEntries.length,
        itemBuilder: (BuildContext context, int index) {
          return SlidableEntry(
            useColorChange: false,
            analysisDialog: false,
              currentEntries: currentEntries,
              ref: ref,
              spaceFromTop: spaceFromTop,
              width: width,
              index: index);
        }),
  ];
}
