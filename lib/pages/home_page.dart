import 'package:camera/camera.dart';
import 'package:doshi/components/add_expense_dialog_box.dart';
import 'package:doshi/components/add_to_vault_dialog_box.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/pages/analysis_page.dart';
import 'package:doshi/pages/this_month_page.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  final CameraDescription camera;
  final CameraDescription backcamera;
  const HomePage({super.key, required this.camera, required this.backcamera});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool canChangePage = true;
  final double pageSwitchScrollLimit = 100;
  final double _spaceFromTop = 90;
  double scrollDelta = 0.0;
  double scrollOffset = 0.0;
  final _scrollController = ScrollController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entriesDatabase = ref.watch(entryDatabaseProvider);
    final entriesDatabaseNotifier = ref.watch(entryDatabaseProvider.notifier);
    List<Entry> currentEntries = entriesDatabase;
    double amountInVault = entriesDatabaseNotifier.amountInVault;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: IgnorePointer(
        ignoring: scrollDelta > 0 && scrollOffset > 0 ? true : false,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 100),
          opacity: scrollDelta > 0 && scrollOffset > 0 ||
                  ref.watch(currentPage) != "Home"
              ? 0
              : 1,
          child: Consumer(builder: (context, ref, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 108,
                    width: width,
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        color: Theme.of(context).colorScheme.onTertiary),
                  ),
                  Container(
                    height: 100,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        color: Theme.of(context).colorScheme.tertiary),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            setDefaultValues(ref);
                            Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                barrierDismissible: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return const Hero(
                                      tag: "addtovault",
                                      child: AddToVaultDialogBox());
                                }));
                          },
                          child: Stack(
                            children: [
                              Hero(
                                tag: "addtovault",
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width / 2.7,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      color: Colors.transparent),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: width / 2.7,
                                height: 60,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)
                                                .withOpacity(0.3),
                                        spreadRadius: 0,
                                        blurRadius: 20,
                                        offset: const Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    color: Colors.lightGreen),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 8),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      "Add",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            setDefaultValues(ref);
                            ref
                                .read(amountText.notifier)
                                .update((state) => '25');
                            Navigator.of(context).push(PageRouteBuilder(
                                opaque: false,
                                barrierDismissible: false,
                                pageBuilder: (BuildContext context, _, __) {
                                  return const Hero(
                                      tag: "deductfromvault",
                                      child: AddExpenseDialogBox());
                                }));
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Hero(
                                tag: "deductfromvault",
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width / 2.7,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      color: Colors.transparent),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: width / 2.7,
                                height: 60,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)
                                                .withOpacity(0.3),
                                        spreadRadius: 0,
                                        blurRadius: 20,
                                        offset: const Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    color: Colors.redAccent),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 8),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      "Deduct",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
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
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  color: Theme.of(context).colorScheme.surface),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Opacity(
                                    opacity: clampDouble(scrollOffset, -80, 0)
                                            .abs() /
                                        80,
                                    child: Text(
                                      ref.watch(currentPage) == "Home"
                                          ? "Analysis"
                                          : "Home",
                                      style: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700),
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
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                color: Theme.of(context).colorScheme.surface),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Opacity(
                                  opacity: canChangePage
                                      ? 1 -
                                          clampDouble(scrollOffset, -80, 80)
                                                  .abs() /
                                              80
                                      : 1,
                                  child: Text(
                                    ref.watch(currentPage),
                                    style: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700),
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
                          clampDouble(
                              scrollOffset * 0.3, -height * 0.75, height * 0.75)
                      : _spaceFromTop -
                          clampDouble(scrollOffset * 1.5, -height * 0.75,
                              height * 0.75),
                  child: Container(
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
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                Positioned.fill(
                  top: scrollOffset <= 0
                      ? _spaceFromTop +
                          25 -
                          clampDouble(
                              scrollOffset * 0.7, -height * 0.75, height * 0.75)
                      : _spaceFromTop +
                          25 -
                          clampDouble(
                              scrollOffset, -height * 0.75, height * 0.75),
                  child: Container(
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
                        color: Theme.of(context).colorScheme.onPrimary),
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
                        if (scrollOffset == 0.0) {
                          setState(() {
                            canChangePage = true;
                          });
                        }
                        if (scrollOffset < -pageSwitchScrollLimit &&
                            canChangePage) {
                          ref.read(analysisOfExpenses.notifier).state = [];
                          ref.read(analysisOfExpenses.notifier).state =
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
                          });
                        }
                      }
                      return true;
                    },
                    child: Consumer(builder: (context, ref, child) {
                      // ignore: unused_local_variable
                      final watcher = ref.watch(analysisOfExpenses);
                      return CustomScrollView(
                          physics: BouncingScrollPhysics(
                              parent: canChangePage
                                  ? const AlwaysScrollableScrollPhysics()
                                  : const NeverScrollableScrollPhysics()),
                          controller: _scrollController,
                          slivers: ref.watch(currentPage) == "Home"
                              ? thisMonthPage(
                                  scrollOffset,
                                  _spaceFromTop,
                                  context,
                                  width,
                                  height,
                                  amountInVault,
                                  ref,
                                  entriesDatabaseNotifier,
                                  currentEntries,
                                  entriesDatabaseNotifier.analysisOfCategories,
                                  widget.camera,
                                  widget.backcamera,
                                )
                              : analysisPage(_spaceFromTop, context, width,
                                  height, ref, entriesDatabaseNotifier));
                    }),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
