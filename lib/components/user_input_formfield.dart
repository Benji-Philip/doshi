import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyTextFormField extends StatefulWidget {
  final List<TextInputFormatter>? inputFormatters;
  final Color borderColorOnFocus;
  final Color borderColor;
  final Color labelColor;
  final String label;
  final TextInputType keyboardType;
  final StateProvider textProvider;
  final TextEditingController commonTextEditingController;
  const MyTextFormField(
      {super.key,
      required this.borderColorOnFocus,
      required this.label,
      required this.borderColor,
      required this.labelColor,
      required this.commonTextEditingController,
      required this.textProvider,
      required this.keyboardType,
      this.inputFormatters});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Builder(builder: (context) {
              return Consumer(builder: (context, ref, child) {
                return TextFormField(
                  maxLines: null,
                  onChanged: (value) {
                    ref
                        .read(widget.textProvider.notifier)
                        .update((state) => value);
                  },
                  onFieldSubmitted: (value) {
                    Navigator.pop(context);
                  },
                  inputFormatters: widget.inputFormatters,
                  keyboardType: widget.keyboardType,
                  controller: widget.commonTextEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                      floatingLabelStyle: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: widget.labelColor),
                      labelText: widget.label,
                      labelStyle: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onTertiary),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: widget.borderColorOnFocus, width: 2)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: widget.borderColor)),
                      contentPadding:
                          const EdgeInsets.only(top: 9, bottom: 9, left: 10)),
                );
              });
            }),
          )
        ],
      ),
    );
  }
}
