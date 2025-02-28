import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlidableBudgetOnboarding extends ConsumerStatefulWidget {
  const SlidableBudgetOnboarding({
    super.key,
  });

  @override
  ConsumerState<SlidableBudgetOnboarding> createState() =>
      _SlidableBudgetState();
}

class _SlidableBudgetState extends ConsumerState<SlidableBudgetOnboarding>
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
    return Container(
      width: MediaQuery.of(context).size.width * 0.86,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onTertiary,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Slidable(
        controller: _slidableController,
        endActionPane: ActionPane(
          extentRatio: 0.5,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              padding: const EdgeInsets.all(0),
              onPressed: (context) {
                HapticFeedback.heavyImpact();
                HapticFeedback.heavyImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("cannot edit right now")));
              },
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit_off_rounded,
            ),
            SlidableAction(
              padding: const EdgeInsets.all(0),
              onPressed: (context) async {
                HapticFeedback.heavyImpact();
                HapticFeedback.heavyImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("cannot delete right now")));
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete_forever_rounded,
            ),
          ],
        ),
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
          child: Container(
            height: 70,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: Colors.amber),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  "Budget",
                  softWrap: true,
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
