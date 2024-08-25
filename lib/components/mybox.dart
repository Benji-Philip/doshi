import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBox extends StatelessWidget {
  final double width;
  final String label;
  final String amount;
  final String? forecastAmount;
  const MyBox(
      {super.key,
      required this.width,
      required this.label,
      required this.amount,
      this.forecastAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width / 3.5,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).colorScheme.tertiary, width: 5),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: amount),
                      TextSpan(
                        text:
                            forecastAmount == null ? "" : " / $forecastAmount",
                        style: GoogleFonts.montserrat(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      )
                    ],
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                label,
                style: GoogleFonts.montserrat(
                    fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
