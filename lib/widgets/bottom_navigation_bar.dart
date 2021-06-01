import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/pages/home.dart';

class CustomButtonNavigationBar extends StatelessWidget {
  const CustomButtonNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home', (route) => false);
                    print(ModalRoute.of(context)!.settings.name);
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_rounded,
                          color: ModalRoute.of(context)!.settings.name == 'home'
                              ? KPrimaryColor
                              : KTextColor,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color:
                                ModalRoute.of(context)!.settings.name == 'home'
                                    ? KPrimaryColor
                                    : KTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: KPrimaryColor,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  splashColor: Colors.white24,
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_basket_rounded,
                          color: KTextColor,
                        ),
                        Text(
                          'Basket',
                          style: TextStyle(
                            color: KTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
