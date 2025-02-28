import 'package:doshi/onboarding/analysis_page_onboarding.dart';
import 'package:doshi/onboarding/onboarding.dart';
import 'package:doshi/components/add_expense_dialog_box.dart';
import 'package:doshi/components/add_to_vault_dialog_box.dart';
import 'package:doshi/isar/entries_database.dart';
import 'package:doshi/onboarding/this_month_page_onboarding.dart';
import 'package:doshi/pages/analysis_page.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final showCamera = StateProvider((state) => true);
final budgetName = StateProvider((state) => "Default");

class HomePageOnboarding extends ConsumerStatefulWidget {
  const HomePageOnboarding({super.key});

  @override
  ConsumerState<HomePageOnboarding> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePageOnboarding> {
  bool canChangePage = true;
  bool preventScrollSpam = true;
  final double pageSwitchScrollLimit = 60;
  final double _spaceFromTop = 90;
  double scrollDelta = 0.0;
  double scrollOffset = 0.0;
  final _scrollController = ScrollController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  double width = 0;
  double height = 0;
  late EntryDatabaseNotifier entriesDatabaseNotifier;

  @override
  void initState() {
    super.initState();
    entriesDatabaseNotifier = ref.read(entryDatabaseProvider.notifier);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    String currency = ref.watch(currencyProvider);
    return  Stack(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Consumer(builder: (context, ref, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: canChangePage
                        ? -scrollOffset * 0.8 - 21
                        : -scrollOffset * 0.2 + 30,
                    left: 14,
                    child: Column(
                      children: [
                        Visibility(
                          visible: canChangePage,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: width * 0.95,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Opacity(
                                      opacity: clampDouble(scrollOffset,
                                                  -pageSwitchScrollLimit, 0)
                                              .abs() /
                                          pageSwitchScrollLimit,
                                      child: SizedBox(
                                        width: width,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: width * 0.7,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment:
                                                    Alignment.centerLeft,
                                                child: Text(
                                                  ref.watch(currentPage) ==
                                                          "Home"
                                                      ? "Analysis"
                                                      : "Home",
                                                  style:
                                                      GoogleFonts.montserrat(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .primary,
                                                          fontSize: 36,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w700),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 22.0, right: 12),
                                              child: Opacity(
                                                opacity:
                                                    ref.watch(currentPage) ==
                                                            "Home"
                                                        ? 0
                                                        : 1,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 35),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: Colors
                                                                  .transparent),
                                                      child: Opacity(
                                                        opacity: 0,
                                                        child: Text(
                                                          currency,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      20),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 35,
                                                      width: 35,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: Colors
                                                                  .transparent),
                                                      child: const Icon(
                                                          Icons.settings),
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: width * 0.95,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Opacity(
                                    opacity: canChangePage
                                        ? 1 -
                                            clampDouble(
                                                        scrollOffset,
                                                        -pageSwitchScrollLimit,
                                                        pageSwitchScrollLimit)
                                                    .abs() /
                                                pageSwitchScrollLimit
                                        : 1,
                                    child: SizedBox(
                                      width: width,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: width * 0.7,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                ref.watch(currentPage) ==
                                                        "Home"
                                                    ? "Home"
                                                    : ref.read(currentPage),
                                                style: GoogleFonts.montserrat(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontSize: 36,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16.0, right: 12),
                                            child: Opacity(
                                              opacity:
                                                  ref.watch(currentPage) ==
                                                          "Home"
                                                      ? 1
                                                      : 0,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 35,
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 35),
                                                    alignment:
                                                        Alignment.center,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors
                                                                .transparent),
                                                    child: Opacity(
                                                      opacity: 0,
                                                      child: Text(
                                                        currency,
                                                        style:
                                                            const TextStyle(
                                                                fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 35,
                                                    width: 35,
                                                    alignment:
                                                        Alignment.center,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors
                                                                .transparent),
                                                    child: const Icon(
                                                        Icons.settings),
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
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    top: scrollOffset <= 0
                        ? _spaceFromTop -
                            clampDouble(scrollOffset * 0.3, -height * 0.75,
                                height * 0.75)
                        : _spaceFromTop -
                            clampDouble(scrollOffset * 1.5, -height * 0.75,
                                height * 0.75),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                          borderRadius: const BorderRadiusDirectional.all(
                              Radius.circular(50)),
                          color: ref.watch(currentPage) != "Home"
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onTertiary),
                    ),
                  ),
                  Positioned.fill(
                    top: scrollOffset <= 0
                        ? _spaceFromTop +
                            25 -
                            clampDouble(scrollOffset * 0.7, -height * 0.75,
                                height * 0.75)
                        : _spaceFromTop +
                            25 -
                            clampDouble(
                                scrollOffset, -height * 0.75, height * 0.75),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 20,
                              offset: const Offset(
                                  0, -2), // changes position of shadow
                            ),
                          ],
                          borderRadius: const BorderRadiusDirectional.all(
                              Radius.circular(50)),
                          color: ref.watch(currentPage) == "Home"
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: height,
                    child: NotificationListener(
                      onNotification: (notif) {
                        if (notif is ScrollUpdateNotification) {
                          if (notif.scrollDelta == null) {
                            return false;
                          }
                          setState(() {
                            scrollOffset = _scrollController.offset;
                            scrollDelta = notif.scrollDelta ?? 0;
                          });
                          if (scrollOffset >= 0) {
                            setState(() {
                              canChangePage = true;
                            });
                          }
                          if (scrollOffset <= -30 && scrollOffset >= -50) {
                            setState(() {
                              preventScrollSpam = true;
                            });
                          }
                          if (scrollOffset < -pageSwitchScrollLimit &&
                              preventScrollSpam) {
                            ref.read(analysisOfCatExpenses.notifier).state =
                                [];
                            ref.read(analysisOfCatExpenses.notifier).state =
                                entriesDatabaseNotifier.analysisOfCategories;
                            ref.read(dateToDisplay.notifier).state =
                                DateTime.now();
                            if (ref.read(currentPage) == "Home") {
                              HapticFeedback.heavyImpact();
                              ref
                                  .read(currentPage.notifier)
                                  .update((state) => "Analysis");
                            } else if (ref.read(currentPage) == "Analysis") {
                              HapticFeedback.heavyImpact();
                              ref
                                  .read(currentPage.notifier)
                                  .update((state) => "Home");
                            }
                            setState(() {
                              canChangePage = false;
                              preventScrollSpam = false;
                            });
                          }
                        }
                        return true;
                      },
                      child: Consumer(builder: (context, ref, child) {
                        // ignore: unused_local_variable
                        final watcher = ref.watch(entryDatabaseProvider);
                        return Opacity(
                          opacity: canChangePage
                              ? scrollOffset <= 0
                                  ? 1 -
                                      clampDouble(
                                                  scrollOffset,
                                                  -(pageSwitchScrollLimit /
                                                      1),
                                                  (pageSwitchScrollLimit / 1))
                                              .abs() /
                                          (pageSwitchScrollLimit / 1)
                                  : 1
                              : 1,
                          child: CustomScrollView(
                              physics: BouncingScrollPhysics(
                                  parent: preventScrollSpam || canChangePage
                                      ? const AlwaysScrollableScrollPhysics()
                                      : const NeverScrollableScrollPhysics()),
                              controller: _scrollController,
                              slivers: ref.watch(currentPage) == "Home"
                                  ? thisMonthPageOnboarding(
                                      _spaceFromTop,
                                      context,
                                      width,
                                      height,
                                      entriesDatabaseNotifier.amountInVault,
                                      ref,
                                      entriesDatabaseNotifier,
                                      entriesDatabaseNotifier.currentEntries,
                                      entriesDatabaseNotifier
                                          .analysisOfCategories,
                                      _scrollController)
                                  : analysisPageOnboarding(
                                      ref
                                          .watch(
                                              entryDatabaseProvider.notifier)
                                          .theListOfTheExpenses,
                                      _spaceFromTop,
                                      context,
                                      width,
                                      height,
                                      ref,
                                      entriesDatabaseNotifier,
                                      currency,
                                      entriesDatabaseNotifier
                                          .totalDailyAverage
                                          .toStringAsFixed(2),
                                      entriesDatabaseNotifier.totalExpenses
                                          .toStringAsFixed(2),
                                    )),
                        );
                      }),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      );
  }
}
