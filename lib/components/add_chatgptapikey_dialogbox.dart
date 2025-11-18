import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:doshi/components/my_button.dart';
import 'package:doshi/components/my_textfield.dart';

class AddChatGptApiKeyDialog extends ConsumerStatefulWidget {
  const AddChatGptApiKeyDialog({super.key});

  @override
  ConsumerState<AddChatGptApiKeyDialog> createState() => _AddChatGptApiKeyDialogState();
}

class _AddChatGptApiKeyDialogState extends ConsumerState<AddChatGptApiKeyDialog> {
  var formatter = DateFormat('yyyyMMddHHmmss');
  final _apiKeyController = TextEditingController();
  final addBudgetFormKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _apiKeyController.text = ref.read(appSettingsDatabaseProvider.notifier).currentSettings[5].appSettingValue;
  }

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
              key: addBudgetFormKey,
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: MyTextField(
                                  isBudget: true,
                                  myController: _apiKeyController,
                                  width: 300,
                                  myHintText: '(Add ChatGPT API Key)',
                                  hintTextSize: 22,
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
                              width: 100,
                              height: 40,
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
                                borderRadius: 40,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  ref.read(appSettingsDatabaseProvider.notifier).editSetting(6, "ChatGptApiKey", _apiKeyController.text);
                                  Navigator.of(context).pop();
                                },
                                width: 100,
                                height: 40,
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
