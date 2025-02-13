import 'package:currency_picker/currency_picker.dart';
import 'package:doshi/components/category_selector.dart';
import 'package:doshi/components/my_button.dart';
import 'package:doshi/isar/entries_database.dart';
import 'package:doshi/pages/home_page.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';

class BackupRestoreDialog extends ConsumerStatefulWidget {
  final EntryDatabaseNotifier entriesDatabaseNotifier;
  const BackupRestoreDialog({super.key, required this.entriesDatabaseNotifier});

  @override
  ConsumerState<BackupRestoreDialog> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<BackupRestoreDialog> {
  final InAppPurchase _iap = InAppPurchase.instance;
  late List<ProductDetails> product;
  bool _iapAvailable = false;
  double scrollOffset = 0.0;
  final _listViewScrollController = ScrollController();

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    _listViewScrollController.dispose();
    super.dispose();
  }

  void _initialize() async {
    _iapAvailable = await _iap.isAvailable();
    Set<String> ids = {"donate_to_developer"};
    if (_iapAvailable) {
      ProductDetailsResponse response = await _iap.queryProductDetails(ids);
      setState(() {
        product = response.productDetails;
      });
    }
  }

  final String feedbackUrl = "https://forms.gle/CbfyvbLuyCJwpWfj8";

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(feedbackUrl);
    if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
      throw 'Could not launch $feedbackUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: Theme.of(context).colorScheme.tertiary),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.7),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.heavyImpact();
                                    widget.entriesDatabaseNotifier.tryBackup();
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    child: Text(
                                      "Backup",
                                      softWrap: true,
                                      style: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    HapticFeedback.heavyImpact();
                                    ref
                                        .read(backupRestoreSuccess.notifier)
                                        .update((state) => true);
                                    await widget.entriesDatabaseNotifier
                                        .tryRestore(ref);

                                    ref
                                        .read(appSettingsDatabaseProvider
                                            .notifier)
                                        .fetchEntries();
                                    ref
                                        .read(entryDatabaseProvider.notifier)
                                        .fetchEntries();
                                    ref
                                        .read(categoryDatabaseProvider.notifier)
                                        .fetchEntries();
                                    ref
                                        .read(subCategoryDatabaseProvider
                                            .notifier)
                                        .fetchEntries();
                                    final List appSettings = await ref
                                        .read(appSettingsDatabaseProvider
                                            .notifier)
                                        .fetchSettings();
                                    if (appSettings.length > 2) {
                                      ref
                                          .read(currencyProvider.notifier)
                                          .update((state) =>
                                              appSettings[2].appSettingValue);
                                    } else {
                                      ref
                                          .read(currencyProvider.notifier)
                                          .update((state) => "\$");
                                    }
                                    if (appSettings.length > 3) {
                                      ref.read(showCamera.notifier).update(
                                          (state) =>
                                              appSettings[3].appSettingValue ==
                                              "true");
                                    } else {
                                      ref
                                          .read(showCamera.notifier)
                                          .update((state) => false);
                                    }
                                    if (mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.lightGreen),
                                    child: Text(
                                      "Restore",
                                      softWrap: true,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onTertiary,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100))),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.heavyImpact();

                                    HapticFeedback.heavyImpact();
                                    showCurrencyPicker(
                                      context: context,
                                      showFlag: true,
                                      showCurrencyName: true,
                                      showCurrencyCode: true,
                                      onSelect: (Currency currency) {
                                        HapticFeedback.lightImpact();
                                        ref
                                            .read(appSettingsDatabaseProvider
                                                .notifier)
                                            .editSetting(3, "CurrencySymbol",
                                                currency.symbol);
                                        ref
                                            .read(currencyProvider.notifier)
                                            .update((state) => currency.symbol);
                                      },
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.deepPurpleAccent),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Symbol : ${ref.watch(currencyProvider)}',
                                          softWrap: true,
                                          style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.heavyImpact();
                                    setDefaultValues(ref);
                                    showGeneralDialog(
                                        pageBuilder: (context, anim1, anim2) {
                                          return const Placeholder();
                                        },
                                        context: context,
                                        transitionBuilder:
                                            (context, anim1, anim2, child) {
                                          return Opacity(
                                              opacity: anim1.value,
                                              child: const CategoryListSelector(
                                                editMode: true,
                                              ));
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 200));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.deepOrange),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Categories : ${ref.watch(categoryDatabaseProvider.notifier).currentCategories.length}',
                                          softWrap: true,
                                          style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onTertiary,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100))),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    HapticFeedback.heavyImpact();
                                    _launchURL();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.teal),
                                    child: Text(
                                      "Feedback",
                                      softWrap: true,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
                                  onTap: () {
                                    HapticFeedback.heavyImpact();
                                    if (_iapAvailable) {
                                      PurchaseParam purchaseParam =
                                          PurchaseParam(
                                              productDetails: product[0]);
                                      _iap.buyConsumable(
                                          purchaseParam: purchaseParam);
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.amber),
                                    child: Text(
                                      "Donate",
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
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
                                  onTap: () {
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Theme.of(context).colorScheme.onTertiary),
                                    child: Text(
                                      "Version 0.5",
                                      softWrap: true,
                                      style: GoogleFonts.montserrat(
                                          color: Theme.of(context).colorScheme.primary,
                                          fontSize: 28,
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
    );
  }
}
