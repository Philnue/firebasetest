import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MitgliedPageInfoItem extends StatelessWidget {
  const MitgliedPageInfoItem(
      {Key? key, required this.firstValue, required this.secondValue})
      : super(key: key);

  final String firstValue, secondValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          firstValue,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                secondValue,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
