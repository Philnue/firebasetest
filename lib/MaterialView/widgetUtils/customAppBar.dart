import 'dart:ui';
 
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.text,
    this.trailing = const Center(),
    this.withBackButton = false,
  }) : super(key: key);

  final String text;
  final Widget trailing;
  final bool withBackButton;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: AppBar(
            centerTitle: false,
            leading: withBackButton == false
                ? MaterialButton(
                    child: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  )
                : null,
            title: Text(text),
            actions: [trailing],
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 60);
}
