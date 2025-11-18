import 'package:doshi/components/my_button.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IsSavingsDialog extends ConsumerStatefulWidget {
  const IsSavingsDialog({super.key});

  @override
  ConsumerState<IsSavingsDialog> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<IsSavingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IsSavingsContainer(
          opacity: 0,
          padBottom: 0,
          padLeft: 8,
          padRight: 0,
          padTop: 8,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        IsSavingsContainer(
          opacity: 1,
          padBottom: 8,
          padLeft: 0,
          padRight: 8,
          padTop: 0,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ],
    );
  }
}

class IsSavingsContainer extends ConsumerStatefulWidget {
  final double padTop;
  final double padBottom;
  final double padLeft;
  final double padRight;
  final Color color;
  final double opacity;
  const IsSavingsContainer({
    super.key,
    required this.padBottom,
    required this.padLeft,
    required this.padRight,
    required this.padTop,
    required this.color,
    required this.opacity,
  });

  @override
  ConsumerState<IsSavingsContainer> createState() => _IsSavingsContainerState();
}

class _IsSavingsContainerState extends ConsumerState<IsSavingsContainer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        child: Padding(
          padding: EdgeInsets.only(
              bottom:
                  widget.padBottom + MediaQuery.of(context).viewInsets.bottom,
              right: widget.padRight,
              top: widget.padTop,
              left: widget.padLeft),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: widget.color),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          ref.read(isSavings.notifier).update((state) => false);
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "in credit",
                            softWrap: true,
                            style: GoogleFonts.montserrat(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dotted),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          ref.read(isSavings.notifier).update((state) => true);
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "to savings",
                            softWrap: true,
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dotted,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
