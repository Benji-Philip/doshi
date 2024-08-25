import 'package:doshi/riverpod/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyTextField extends ConsumerStatefulWidget {
  final double width;
  final double? innerHorizontalPadding;
  final TextEditingController? myController;
  final double? innerVerticalPadding;
  final String myHintText;
  final double? myBorderRadius;
  final TextInputType? myInputType;
  final List<TextInputFormatter>? myTextFilter;
  final double? hintTextSize;
  final TextStyle? myTextStyle;
  final TextStyle? myHintTextStyle;
  final bool? iconVisible;
  final bool? validator;
  const MyTextField({
    super.key,
    required this.width,
    this.innerHorizontalPadding,
    required this.myHintText,
    this.myBorderRadius,
    this.innerVerticalPadding,
    this.myController,
    this.myInputType,
    this.myTextFilter,
    this.hintTextSize,
    this.myTextStyle,
    this.iconVisible,
    this.myHintTextStyle,
    this.validator,
  });

  @override
  ConsumerState<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends ConsumerState<MyTextField> {
  @override
  Widget build(BuildContext context) {
    double myFontSize = 20;
    return Container(
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(widget.myBorderRadius ?? 10)),
          color: Theme.of(context).colorScheme.onPrimary),
      width: widget.width,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: widget.innerHorizontalPadding ?? 12,
            vertical: widget.innerVerticalPadding ?? 0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                autofocus: true,
                inputFormatters: widget.myTextFilter,
                validator: (textField) {
                  bool validator = widget.validator ?? true;
                  if (textField == null ||
                      textField.isEmpty && validator == true) {
                    return 'cannot be empty';
                  } else {
                    for (var i = 0;
                        i <
                            ref
                                    .read(categoryDatabaseProvider.notifier)
                                    .currentCategories
                                    .length +
                                1;
                        i++) {
                      if (i !=
                          ref
                              .read(categoryDatabaseProvider.notifier)
                              .currentCategories
                              .length) {
                        if (textField.toLowerCase() ==
                            ref
                                .read(categoryDatabaseProvider.notifier)
                                .currentCategories[i]
                                .category
                                .toLowerCase()) {
                          return 'already exists';
                        }
                      }
                    }
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {
                    widget.myController!.text = text;
                  });
                },
                controller: widget.myController,
                style: GoogleFonts.montserrat(
                    textStyle: widget.myTextStyle ??
                        TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(1),
                        ),
                    fontSize: widget.hintTextSize ?? myFontSize,
                    fontWeight: FontWeight.w700),
                keyboardType: widget.myInputType ?? TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: widget.myHintText,
                  hintStyle: GoogleFonts.montserrat(
                      textStyle: widget.myHintTextStyle ??
                          TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5),
                              fontSize: myFontSize),
                      fontSize: widget.hintTextSize ?? myFontSize,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
