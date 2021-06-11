import 'package:flutter/cupertino.dart';

const KTextColor = Color(0xFF262626);
const KPrimaryColor = Color(0xFF09B44D);
const KSecondaryColor = Color(0xFFD0F1DD);
const KBgColor = Color(0xFFF6F6F6);
const KClientId = 'wXj0Hd2MRsBMybPDmLpQmQ68Mb6vPq1QLcMkvCYh';
const KClientSecret =
    'Xk2Aphx090vmyoaflMkFL3ylTnRWrFU2BDgGBHxGIu0PTKFsP3RfhxWv2qKZrANhmlnItDCrTF5HCMEeNqT6djkIbCicJ9gip6onmVXwZa9sBlUgqVLm17bg18b5MpsA';
const KMobileScreenSize = 500;
const KTabletScreenSize = 768;

Widget makeDismissible({required Widget child,required BuildContext context}) => GestureDetector(
  behavior: HitTestBehavior.opaque,
  onTap: () => Navigator.of(context).pop(),
  child: GestureDetector(
    onTap: () {},
    child: child,
  ),
);