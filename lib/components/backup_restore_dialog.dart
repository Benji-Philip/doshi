import 'package:doshi/components/my_button.dart';
import 'package:doshi/isar/entries_database.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

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

  void _initialize () async {
    _iapAvailable = await _iap.isAvailable();
    print("init: "+_iapAvailable.toString());
    Set<String> ids = {"donate_to_developer"};
    if (_iapAvailable) {
      ProductDetailsResponse response = await _iap.queryProductDetails(ids);
      setState(() {
        product = response.productDetails;
      });
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                child: Text(
                                  "Backup",
                                  softWrap: true,
                                  style: GoogleFonts.montserrat(
                                      color:
                                          Theme.of(context).colorScheme.surface,
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
                                ref
                                    .read(backupRestoreSuccess.notifier)
                                    .update((state) => true);
                                widget.entriesDatabaseNotifier.tryRestore();
                                Navigator.of(context).pop();
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
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.heavyImpact();
                                print(_iapAvailable);
                                if (_iapAvailable) {
                                PurchaseParam purchaseParam = PurchaseParam(productDetails: product[0]);
                                _iap.buyConsumable(purchaseParam: purchaseParam);
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
                  ],
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
