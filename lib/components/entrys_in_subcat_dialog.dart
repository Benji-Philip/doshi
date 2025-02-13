import 'package:doshi/components/my_button.dart';
import 'package:doshi/components/slidable_entry.dart';
import 'package:doshi/isar/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final entriesForSubCatDialog = StateProvider<List<Entry>>((ref) => []);

class EntrysInSubCatDialog extends ConsumerStatefulWidget {
  const EntrysInSubCatDialog({super.key});

  @override
  ConsumerState<EntrysInSubCatDialog> createState() =>
      _EntrysInSubCatDialogState();
}

class _EntrysInSubCatDialogState extends ConsumerState<EntrysInSubCatDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.5),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
                padding: const EdgeInsets.symmetric( vertical: 36.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric( horizontal: 30.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ThisContainer(
                      opacity: 0,
                      padBottom: 0,
                      padLeft: 8,
                      padRight: 0,
                      padTop: 8,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    ThisContainer(
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
    required this.padBottom,
    required this.padLeft,
    required this.padRight,
    required this.padTop,
    required this.color,
    required this.opacity,
  });

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
              padding: const EdgeInsets.all(26.0),
              child: Opacity(
                opacity: widget.opacity,
                child: Consumer(builder: (context, ref, child) {
                  return Column(
                    children: List.generate(ref.watch(entriesForSubCatDialog).length, (index) {
                      return SlidableEntry(
                        analysisDialog: true,
                          currentEntries: ref.watch(entriesForSubCatDialog),
                          ref: ref,
                          spaceFromTop: 0,
                          width: MediaQuery.of(context).size.width,
                          index: index);
                    }),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
