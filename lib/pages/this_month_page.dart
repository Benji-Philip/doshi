import 'dart:io';

import 'package:camera/camera.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:doshi/components/add_to_vault_dialog_box.dart';
import 'package:doshi/components/backup_restore_dialog.dart';
import 'package:doshi/components/break_savings_dialog.dart';
import 'package:doshi/components/edit_savings_dialog_box.dart';
import 'package:doshi/components/mybox.dart';
import 'package:doshi/components/take_picture_screen.dart';
import 'package:doshi/isar/entries_database.dart';
import 'package:doshi/isar/entry.dart';
import 'package:doshi/logic/sort_entries.dart';
import 'package:doshi/pages/history_page.dart';
import 'package:doshi/pages/home_page.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<Widget> thisMonthPage(
  double scrollOffset,
  double spaceFromTop,
  BuildContext context,
  double width,
  double height,
  double amountInVault,
  WidgetRef ref,
  EntryDatabaseNotifier entriesDatabaseNotifier,
  List<Entry> currentEntries,
  List<CategoryAnalysisEntry> analysisOfExpensesThisMonth,
  CameraDescription camera,
  CameraDescription backcamera,
  ScrollController scrollController,
) {
  List<Widget> homePage = [
    SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Opacity(
            opacity: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 43.0, right: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      showCurrencyPicker(
                        context: context,
                        showFlag: true,
                        showCurrencyName: true,
                        showCurrencyCode: true,
                        onSelect: (Currency currency) {
                          HapticFeedback.lightImpact();
                          ref
                              .read(appSettingsDatabaseProvider.notifier)
                              .editSetting(
                                  3, "CurrencySymbol", currency.symbol);
                          ref
                              .read(currencyProvider.notifier)
                              .update((state) => currency.symbol);
                        },
                      );
                      scrollController.animateTo(-80,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeInCubic);
                    },
                    child: Container(
                      height: 35,
                      constraints: const BoxConstraints(minWidth: 35),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        ref.watch(currencyProvider),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      showGeneralDialog(
                          pageBuilder: (context, anim1, anim2) {
                            return const Placeholder();
                          },
                          context: context,
                          transitionBuilder: (context, anim1, anim2, child) {
                            return Opacity(
                                opacity: anim1.value,
                                child: BackupRestoreDialog(
                                    entriesDatabaseNotifier:
                                        entriesDatabaseNotifier));
                          },
                          transitionDuration:
                              const Duration(milliseconds: 200));
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white)),
                      child: const Icon(Icons.save_rounded),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    SliverToBoxAdapter(
      child: Padding(
        padding:
            EdgeInsets.only(top: -20.0 + spaceFromTop, right: 21, left: 21),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 24.0, top: 0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
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
                          child: Container(
                            height: 130,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.3),
                                    spreadRadius: 0,
                                    blurRadius: 20,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                border: Border.all(
                                    width: 5,
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                color: Theme.of(context).colorScheme.onPrimary),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          amountInVault == 0.0
                                              ? "${ref.watch(currencyProvider)}0.0"
                                              : ref.watch(currencyProvider) +
                                                  amountInVault
                                                      .toStringAsFixed(2),
                                          style: GoogleFonts.montserrat(
                                              fontSize: 60,
                                              fontWeight: FontWeight.w700,
                                              color: amountInVault > 0.0
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                  : Colors.redAccent),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SizedBox(
                                            height: 20,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                amountInVault >= 0.0
                                                    ? "- left in credit -"
                                                    : "- left in debt -",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: ref.watch(showCamera),
                      child: Flexible(
                        flex: 1,
                        child: Consumer(builder: (context, ref, child) {
                          // ignore: unused_local_variable
                          final selfiWatcher = ref.watch(selfiePath);
                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TakePictureScreen(
                                            camera: camera,
                                            backcamera: backcamera,
                                          )));
                            },
                            child: Stack(
                              children: [
                                const SizedBox(
                                  height: 130,
                                  child: Center(
                                      child:
                                          Icon(Icons.camera_enhance_rounded)),
                                ),
                                Container(
                                  height: 130,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: ref.read(selfiePath) == "" &&
                                                  ref
                                                      .read(
                                                          appSettingsDatabaseProvider
                                                              .notifier)
                                                      .currentSettings
                                                      .isNotEmpty
                                              ? FileImage(File(ref
                                                  .read(
                                                      appSettingsDatabaseProvider
                                                          .notifier)
                                                  .currentSettings[1]
                                                  .appSettingValue))
                                              : FileImage(
                                                  File(ref.read(selfiePath)))),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)
                                                  .withOpacity(0.3),
                                          spreadRadius: 0,
                                          blurRadius: 20,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                      border: Border.all(
                                          width: 5,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      color: Colors.transparent),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber, width: 3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'This Month',
                            style: GoogleFonts.montserrat(
                                fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: MyBox(
                          borderColor: entriesDatabaseNotifier.todaysExpenses >
                                  entriesDatabaseNotifier.perDayForecast
                              ? Colors.red
                              : Theme.of(context).colorScheme.onTertiary,
                          width: width,
                          label: 'Today',
                          forecastAmount: entriesDatabaseNotifier.perDayForecast
                              .toStringAsFixed(2),
                          amount:
                              "${ref.watch(currencyProvider)}${entriesDatabaseNotifier.todaysExpenses}")),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: MyBox(
                          borderColor: entriesDatabaseNotifier.sumOfthisWeeksExpenses >
                                  entriesDatabaseNotifier.perWeekForecast
                              ? Colors.red
                              : Theme.of(context).colorScheme.onTertiary,
                          width: width,
                          label: 'This Week',
                          forecastAmount: entriesDatabaseNotifier
                              .perWeekForecast
                              .toStringAsFixed(2),
                          amount: ref.watch(currencyProvider) +
                              entriesDatabaseNotifier.sumOfthisWeeksExpenses
                                  .toStringAsFixed(2)))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: MyBox(
                          width: width,
                          label: 'Total',
                          amount: ref.watch(currencyProvider) +
                              entriesDatabaseNotifier.thisMonthExpenses
                                  .toStringAsFixed(2))),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: MyBox(
                          width: width,
                          label: 'Daily Average',
                          amount: ref.watch(currencyProvider) +
                              entriesDatabaseNotifier.dailyAverage
                                  .toStringAsFixed(2)))
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0.0, left: 0, top: 15),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Savings',
                      style: GoogleFonts.montserrat(
                          fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 0.0, left: 0, top: 21),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setDefaultValues(ref);
                        ref.read(amountText.notifier).update((state) =>
                            entriesDatabaseNotifier.amountInSavings
                                .toStringAsFixed(2));
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            barrierDismissible: false,
                            pageBuilder: (BuildContext context, _, __) {
                              return const Hero(
                                  tag: "addtovault",
                                  child: EditSavingsDialogBox());
                            }));
                      },
                      child: Container(
                        constraints: BoxConstraints(minWidth: width * 0.5),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.tertiary,
                              width: 5),
                          color: Theme.of(context).colorScheme.onPrimary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              ref.watch(currencyProvider) +
                                  entriesDatabaseNotifier.amountInSavings
                                      .toStringAsFixed(2),
                              style: GoogleFonts.montserrat(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: entriesDatabaseNotifier.amountInSavings == 0
                        ? false
                        : true,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setDefaultValues(ref);
                        ref.read(amountText.notifier).update((state) => ref
                            .read(entryDatabaseProvider.notifier)
                            .amountInSavings
                            .toString());
                        showGeneralDialog(
                            pageBuilder: (context, anim1, anim2) {
                              return const Placeholder();
                            },
                            context: context,
                            transitionBuilder: (context, anim1, anim2, child) {
                              return Opacity(
                                  opacity: anim1.value,
                                  child: const BreakSavingsDialog());
                            },
                            transitionDuration:
                                const Duration(milliseconds: 200));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Container(
                          width: width * 0.35,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            border: Border.all(color: Colors.green),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Break!",
                                style: GoogleFonts.montserrat(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Theme.of(context).colorScheme.surface),
                              ),
                            ),
                          ),
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
    ),
    const SliverToBoxAdapter(
        child: SizedBox(
      height: 150,
    ))
  ];
  homePage.insertAll(3, historyPage(spaceFromTop, width, ref, currentEntries));
  return homePage;
}
