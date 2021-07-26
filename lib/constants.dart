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
const kIpAddress='192.168.1.3';
const List<String> kCollectionImageUrls = [
  'https://twodevguys.com/foodcam-images/categories/gettyimages-1031354828-612x612.jpg',
  'https://twodevguys.com/foodcam-images/categories/gettyimages-1150012244-612x612.jpg',
  'https://twodevguys.com/foodcam-images/categories/gettyimages-1155240409-612x612.jpg',
  'https://twodevguys.com/foodcam-images/categories/gettyimages-1182467837-612x612.jpg',
  'https://twodevguys.com/foodcam-images/categories/gettyimages-1208790364-612x612.jpg',
  'https://twodevguys.com/foodcam-images/categories/gettyimages-1213480705-612x612.jpg',
  'https://twodevguys.com/foodcam-images/categories/gettyimages-807031028-612x612.jpg',
  'https://twodevguys.com/foodcam-images/categories/gettyimages-861188910-612x612.jpg',
  'https://twodevguys.com/foodcam-images/categories/gettyimages-882314790-612x612.jpg',
  'https://twodevguys.com/foodcam-images/categories/gettyimages-938742222-612x612.jpg',
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
