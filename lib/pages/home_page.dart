import 'package:camera/camera.dart';
import 'package:doshi/onboarding/onboarding.dart';
import 'package:doshi/components/add_expense_dialog_box.dart';
import 'package:doshi/components/add_to_vault_dialog_box.dart';
import 'package:doshi/isar/entries_database.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/pages/analysis_page.dart';
import 'package:doshi/pages/this_month_page.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final showCamera = StateProvider((state) => true);
final budgetName = StateProvider((state) => "Default");

class HomePage extends ConsumerStatefulWidget {
  final CameraDescription camera;
  final CameraDescription backcamera;
  const HomePage({super.key, required this.camera, required this.backcamera});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
    // ignore: unused_local_variable
    bool watchForHomePageUpdates = ref.watch(showCamera);
    List<Entry> currentEntries = ref.watch(entryDatabaseProvider);
    double amountInVault = entriesDatabaseNotifier.amountInVault;
    String totalDailyAverage =
        entriesDatabaseNotifier.totalDailyAverage.toStringAsFixed(2);
    String totalExpenses =
        entriesDatabaseNotifier.totalExpenses.toStringAsFixed(2);
    String currency = ref.watch(currencyProvider);
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: IgnorePointer(
        ignoring: scrollDelta > 0 && scrollOffset > 0 ||
                ref.watch(currentPage) != "Home" ||
                !ref.watch(endOnBoarding)
            ? true
            : false,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: scrollDelta > 0 && scrollOffset > 0 ||
                  ref.watch(currentPage) != "Home" ||
                  !ref.watch(endOnBoarding)
              ? 0
              : 1,
          child: Consumer(builder: (context, ref, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Visibility(
                    visible: !(scrollOffset >
                        MediaQuery.of(context).size.height / 2),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 98,
                          width: width,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 0, 0)
                                      .withAlpha((0.3 * 255).round()),
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
                          height: 90,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              color: Theme.of(context).colorScheme.tertiary),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  if (ref
                                      .read(
                                          appSettingsDatabaseProvider.notifier)
                                      .currentSettings
                                      .isNotEmpty) {
                                    HapticFeedback.heavyImpact();
                                    bool currentCamState = ref
                                            .read(appSettingsDatabaseProvider
                                                .notifier)
                                            .currentSettings[3]
                                            .appSettingValue ==
                                        "true";
                                    if (currentCamState) {
                                      ref
                                          .read(appSettingsDatabaseProvider
                                              .notifier)
                                          .editSetting(
                                              4, "EnableCamera", "false");
                                      ref
                                          .read(showCamera.notifier)
                                          .update((state) => false);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Disabled Easter Egg")));
                                    } else {
                                      ref
                                          .read(appSettingsDatabaseProvider
                                              .notifier)
                                          .editSetting(
                                              4, "EnableCamera", "true");
                                      ref
                                          .read(showCamera.notifier)
                                          .update((state) => true);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Enabled Easter Egg")));
                                    }
                                  }
                                },
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setDefaultValues(ref);
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      barrierDismissible: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) {
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
                                        height: 55,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Colors.transparent),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: width / 2.7,
                                      height: 55,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 0, 0, 0)
                                                  .withAlpha(
                                                      (0.3 * 255).round()),
                                              spreadRadius: 0,
                                              blurRadius: 20,
                                              offset: const Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
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
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onLongPress: () {
                                  if (ref
                                      .read(
                                          appSettingsDatabaseProvider.notifier)
                                      .currentSettings
                                      .isNotEmpty) {
                                    HapticFeedback.heavyImpact();
                                    bool currentCamState = ref
                                            .read(appSettingsDatabaseProvider
                                                .notifier)
                                            .currentSettings[3]
                                            .appSettingValue ==
                                        "true";
                                    if (currentCamState) {
                                      ref
                                          .read(appSettingsDatabaseProvider
                                              .notifier)
                                          .editSetting(
                                              4, "EnableCamera", "false");
                                      ref
                                          .read(showCamera.notifier)
                                          .update((state) => false);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Disabled Easter Egg")));
                                    } else {
                                      ref
                                          .read(appSettingsDatabaseProvider
                                              .notifier)
                                          .editSetting(
                                              4, "EnableCamera", "true");
                                      ref
                                          .read(showCamera.notifier)
                                          .update((state) => true);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Enabled Easter Egg")));
                                    }
                                  }
                                },
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setDefaultValues(ref);
                                  ref
                                      .read(amountText.notifier)
                                      .update((state) => '25');
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      barrierDismissible: false,
                                      pageBuilder:
                                          (BuildContext context, _, __) {
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
                                        height: 55,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Colors.transparent),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: width / 2.7,
                                      height: 55,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                      255, 0, 0, 0)
                                                  .withAlpha(
                                                      (0.3 * 255).round()),
                                              spreadRadius: 0,
                                              blurRadius: 20,
                                              offset: const Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
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
                                                fontSize: 18,
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
                  ),
                  Visibility(
                    visible:
                        (scrollOffset > MediaQuery.of(context).size.height / 2),
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        _scrollController.animateTo(0,
                            duration: Duration(
                                milliseconds: (scrollOffset / 2)
                                    .clamp(500, 2000)
                                    .round()),
                            curve: Curves.easeInOutCirc);
                      },
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 54,
                            width: 50,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withAlpha((0.3 * 255).round()),
                                    spreadRadius: 0,
                                    blurRadius: 20,
                                    offset: const Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                color:
                                    Theme.of(context).colorScheme.onTertiary),
                          ),
                          Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(100)),
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                              child: const Icon(
                                Icons.swipe_up_alt_rounded,
                                size: 32,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
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
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100)),
                                    color:
                                        Theme.of(context).colorScheme.surface),
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
                                                    Opacity(
                                                      opacity: 0,
                                                      child: Container(
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
                                                          child: const Icon(Icons
                                                              .replay_rounded)),
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
                                    .withAlpha((0.3 * 255).round()),
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
                                    .withAlpha((0.7 * 255).round()),
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
                                    ? thisMonthPage(
                                        _spaceFromTop,
                                        context,
                                        width,
                                        height,
                                        amountInVault,
                                        ref,
                                        entriesDatabaseNotifier,
                                        currentEntries,
                                        entriesDatabaseNotifier
                                            .analysisOfCategories,
                                        widget.camera,
                                        widget.backcamera,
                                        _scrollController)
                                    : analysisPage(
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
                                        totalDailyAverage,
                                        totalExpenses)),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          if (!ref.watch(endOnBoarding)) const Onboarding(),
        ],
      ),
    );
  }
}
