import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:doshi/components/color_picker_dialogbox.dart';
import 'package:doshi/components/my_button.dart';
import 'package:doshi/components/my_textfield.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  var formatter = DateFormat('yyyyMMddHHmmss');
  final _categoryController = TextEditingController();
  final addCategoryFormKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
            controller: _scrollController,
            child: Form(
              key: addCategoryFormKey,
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
                          // Category name field
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  showDialog(
                                      barrierColor:
                                          Colors.black.withAlpha((0.8*255).round()),
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
                                child: MyTextField(
                                  myController: _categoryController,
                                  width: 300,
                                  myHintText: '(category)',
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
                                  if (addCategoryFormKey.currentState!
                                      .validate()) {
                                    ref
                                        .read(categoryDatabaseProvider.notifier)
                                        .addCategory(_categoryController.text,
                                            ref.read(categoryColor).toARGB32());
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
