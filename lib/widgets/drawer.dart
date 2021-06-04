import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';

import 'drawer_list_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
    required this.name,
  }) : super(key: key);
  final name;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color(0xFFF6F6F6),
      ),
      child: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: KSecondaryColor,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'lib/assets/avatar.png',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: KTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DrawerListItem(
                    text: "Account",
                    iconPath: 'lib/assets/user.png',
                    onTap: () {},
                  ),
                  SizedBox(height: 25.0),
                  DrawerListItem(
                    text: "Collections",
                    iconPath: 'lib/assets/window.png',
                    onTap: () {},
                  ),
                  SizedBox(height: 25.0),
                  DrawerListItem(
                    text: "Allergy",
                    iconPath: 'lib/assets/allergy.png',
                    onTap: () {},
                  ),
                  SizedBox(height: 25.0),
                  DrawerListItem(
                    text: "Settings",
                    iconPath: 'lib/assets/settings.png',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Food Cam V0",
                        style: TextStyle(
                          color: Color(0x40262626),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: KPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
