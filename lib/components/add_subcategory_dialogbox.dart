import 'package:doshi/components/my_subcat_textfield.dart';
import 'package:doshi/isar/subcategory_entry.dart';
import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:doshi/components/color_picker_dialogbox.dart';
import 'package:doshi/components/my_button.dart';

class AddSubCategory extends StatefulWidget {
  final List<SubCategoryEntry> currentSubCats;
  const AddSubCategory({super.key, required this.currentSubCats});

  @override
  State<AddSubCategory> createState() => _AddSubCategoryState();
}

class _AddSubCategoryState extends State<AddSubCategory> {
  var formatter = DateFormat('yyyyMMddHHmmss');
  final _subCategoryController = TextEditingController();
  final addSubCategoryFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.onTertiary, width: 5),
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: SingleChildScrollView(
            child: Form(
              key: addSubCategoryFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  showDialog(
                                      barrierColor:
                                          Colors.black.withOpacity(0.8),
                                      context: context,
                                      builder: (context) =>
                                          const MyColorPicker());
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child:
                                      Consumer(builder: (context, ref, child) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: ref.watch(categoryColor)),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: MySubCatTextField(
                                  currentSubCats: widget.currentSubCats,
                                  myController: _subCategoryController,
                                  width: 300,
                                  myHintText: '(subcategory)',
                                  hintTextSize: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // confirm/cancel buttons
                  SizedBox(
                    width: width,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyButton(
                              borderRadius: 50,
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Navigator.of(context).pop();
                              },
                              width: 130,
                              height: 50,
                              iconSize: 32,
                              myIcon: Icons.close_rounded,
                              iconColor: Colors.white,
                              buttonColor: Colors.redAccent,
                              splashColor: Colors.red.shade900,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Consumer(builder: (context, ref, child) {
                              return MyButton(
                                borderRadius: 50,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  if (addSubCategoryFormKey.currentState!
                                      .validate()) {
                                    ref
                                        .read(subCategoryDatabaseProvider
                                            .notifier)
                                        .addSubCategory(
                                            _subCategoryController.text,
                                            ref.read(categoryColor).value,
                                            ref.read(categoryText));
                                    Navigator.of(context).pop();
                                  }
                                },
                                width: 130,
                                height: 50,
                                iconSize: 32,
                                myIcon: Icons.check_rounded,
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
