import 'package:flutter/cupertino.dart';

const Color kTextColor = Color(0xFF262626);
const Color kPrimaryColor = Color(0xFF09B44D);
const Color kSecondaryColor = Color(0xFFD0F1DD);
const Color kBgColor = Color(0xFFF6F6F6);
const String kClientId = 'wXj0Hd2MRsBMybPDmLpQmQ68Mb6vPq1QLcMkvCYh';
const String kClientSecret =
    'Xk2Aphx090vmyoaflMkFL3ylTnRWrFU2BDgGBHxGIu0PTKFsP3RfhxWv2qKZrANhmlnItDCrTF5HCMEeNqT6djkIbCicJ9gip6onmVXwZa9sBlUgqVLm17bg18b5MpsA';
const kMobileScreenSize = 500;
const kTabletScreenSize = 768;
const List<String> kCollectionImageUrls = [
  'https://image.freepik.com/free-photo/high-angle-fast-food-white-table_23-2148273120.jpg',
  'https://image.freepik.com/free-photo/ingredients-healthy-foods-selection-concept-healthy-food-set-up_35641-2941.jpg',
  'https://img.freepik.com/free-photo/organic-food-background-vegetables-basket_135427-233.jpg?size=338&ext=jpg',
  'https://image.freepik.com/free-photo/mixed-fruits-with-apple-banana-orange-other_74190-938.jpg',
  'https://image.freepik.com/free-photo/eastern-sweets_2829-14162.jpg',
];
Widget makeDismissible(
        {required Widget child, required BuildContext context}) =>
    GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
