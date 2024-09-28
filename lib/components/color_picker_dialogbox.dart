import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyColorPicker extends StatefulWidget {
  const MyColorPicker({super.key});

  @override
  State<MyColorPicker> createState() => _MyColorPickerState();
}

final categoryColor =
    StateProvider((ref) => const Color.fromARGB(255, 237, 119, 110));

class _MyColorPickerState extends State<MyColorPicker> {
  Widget buildColorPicker(WidgetRef ref) => MaterialPicker(
        pickerColor: ref.watch(categoryColor),
        onColorChanged: (color) => setState(() {
          ref.read(categoryColor.notifier).update((state) => color);
          Navigator.of(context).pop();
        }),
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(30),
        child: Consumer(builder: (context, ref, child) {
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.tertiary),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: buildColorPicker(ref),
                  ),
                ],
              ));
        }));
  }
}
