import 'package:flutter/material.dart';

class NewAemterItem extends StatelessWidget {
  const NewAemterItem({
    Key? key,
    required this.left,
    required this.right,
  }) : super(key: key);

  final String left, right;

  @override
  Widget build(BuildContext context) {
    return Card(
        //color: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        child:
            //  ListTile(
            //   leading: Text(
            //     left,
            //     style: const TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 22,
            //     ),
            //   ),
            //   trailing: Text(
            //     right,
            //     style: const TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
            Column(
          children: [
            Text(
              left,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              right,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ],
        ));
  }
}
