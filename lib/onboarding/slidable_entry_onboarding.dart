import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SlidableEntryOnboarding extends StatefulWidget {
  const SlidableEntryOnboarding({super.key});

  @override
  State<SlidableEntryOnboarding> createState() =>
      _SlidableEntryOnboardingState();
}

class _SlidableEntryOnboardingState extends State<SlidableEntryOnboarding>
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
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("cannot edit right now")));
              },
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit_off_rounded,
            ),
            SlidableAction(
              padding: const EdgeInsets.all(0),
              onPressed: (context) async {
                HapticFeedback.heavyImpact();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("cannot delete right now")));
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
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onTertiary,
              border: Border.all(
                  color: Theme.of(context).colorScheme.onTertiary, width: 3),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 4, right: 21.0, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100))),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: Text(
                                      "Category",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                          decorationColor: const Color.fromARGB(
                                              0, 255, 255, 255),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, right: 6),
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100))),
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    "Subcategory",
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                        decorationColor: const Color.fromARGB(
                                            0, 255, 255, 255),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withAlpha((0.75*255).round()),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 19.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 9),
                                    child: Container(
                                      width: 3,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withAlpha((0.5*255).round()),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      'This is a note',
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                          decorationColor: const Color.fromARGB(
                                              0, 255, 255, 255),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withAlpha((0.75*255).round()),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
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
                      child: Consumer(builder: (context, ref, child) {
                        return Text(
                          "-${ref.watch(currencyProvider)}25",
                          softWrap: true,
                          style: GoogleFonts.montserrat(
                              decorationColor:
                                  const Color.fromARGB(0, 255, 255, 255),
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
