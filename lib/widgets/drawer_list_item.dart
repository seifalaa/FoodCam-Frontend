import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';

class DrawerListItem extends StatelessWidget {
  const DrawerListItem({
    Key? key,
    required this.text,
    required this.iconPath,
    required this.onTap,
  }) : super(key: key);
  final text;
  final iconPath;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x66000000),
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
            )
          ],
          borderRadius: BorderRadius.circular(100),
        ),
        child: Material(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: InkWell(
            onTap: onTap,
            // splashColor: Colors.yellow,
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                children: [
                  Image.asset(iconPath,
                  width: 20.0,
                  height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: KTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
