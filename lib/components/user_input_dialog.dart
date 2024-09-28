import 'package:doshi/components/user_input_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserInputDialog extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final String label;
  final StateProvider textProvider;
  final TextEditingController commonTextEditingController;
  const UserInputDialog(
      {super.key,
      required this.commonTextEditingController,
      required this.label,
      required this.textProvider,
      required this.keyboardType,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 110,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Theme.of(context).colorScheme.onTertiary),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                color: Theme.of(context).colorScheme.onPrimary),
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: MyTextFormField(
                  inputFormatters: inputFormatters,
                  keyboardType: keyboardType,
                  textProvider: textProvider,
                  commonTextEditingController: commonTextEditingController,
                  labelColor: Colors.amber,
                  borderColor: Theme.of(context).colorScheme.onTertiary,
                  borderColorOnFocus: Theme.of(context).colorScheme.onTertiary,
                  label: label),
            ),
          ),
        ],
      ),
    );
  }
}
