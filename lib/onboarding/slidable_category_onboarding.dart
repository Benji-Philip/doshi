import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlidableCategoryOnboarding extends ConsumerStatefulWidget {
  const SlidableCategoryOnboarding({
    super.key,
  });

  @override
  ConsumerState<SlidableCategoryOnboarding> createState() =>
      _SlidableCategoryState();
}

class _SlidableCategoryState extends ConsumerState<SlidableCategoryOnboarding>
    with SingleTickerProviderStateMixin {
  late SlidableController _slidableController;
  bool openEnd = false;

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController(this);
  }

  @override
  void dispose() {
    _slidableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.amber),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.delete_forever_rounded,
                            color: Color.fromARGB(0, 255, 255, 255),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "+",
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
        Slidable(
          controller: _slidableController,
          endActionPane: ActionPane(
              extentRatio: 0.5,
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  padding: const EdgeInsets.only(left: 10),
                  onPressed: (context) {
                    HapticFeedback.lightImpact();

                    HapticFeedback.heavyImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("cannot edit right now")));
                  },
                  backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  icon: Icons.edit_off_rounded,
                ),
                SlidableAction(
                  padding: const EdgeInsets.only(right: 10),
                  onPressed: (context) {
                    HapticFeedback.heavyImpact();
                    HapticFeedback.heavyImpact();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("cannot delete right now")));
                  },
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.surface,
                  icon: Icons.delete_forever_rounded,
                ),
              ]),
          child: GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              if (openEnd) {
                _slidableController.openStartActionPane();
                openEnd = false;
              } else {
                _slidableController.openEndActionPane();
                openEnd = true;
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onTertiary,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(
                        width: 5,
                        color: Theme.of(context).colorScheme.onTertiary)),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Category",
                    softWrap: true,
                    style: GoogleFonts.montserrat(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
