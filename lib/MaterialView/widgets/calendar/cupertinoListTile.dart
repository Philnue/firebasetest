import 'package:flutter/material.dart';

class CupertinoListTile extends StatefulWidget {
  final IconData leading;
  final String title;

  final String trailing;

  const CupertinoListTile(
      {Key? key,
      required this.leading,
      required this.title,
      required this.trailing})
      : super(key: key);

  @override
  _StatefulStateCupertino createState() => _StatefulStateCupertino();
}

class _StatefulStateCupertino extends State<CupertinoListTile> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      //padding: const EdgeInsets.all(0),
      // 7 10
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.1,
            height: 25,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Icon(
                widget.leading,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: width * 0.3,
            height: 25,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: width * 0.5,
            height: 25,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Align(
                  child: Text(
                    widget.trailing,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
