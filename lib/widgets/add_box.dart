import 'package:flutter/material.dart';

import '../constants.dart';

class AddBox extends StatelessWidget {
  const AddBox({
    Key? key,
    required this.onTab,
  }) : super(key: key);
  final Function onTab;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black12,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            onTab();
          },
          child: Icon(
            Icons.add_rounded,
            size: 50,
            color: KBgColor,
          ),
        ),
      ),
    );
  }
}
