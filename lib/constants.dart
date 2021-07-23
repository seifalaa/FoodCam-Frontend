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
  'https://drive.google.com/file/d/1qC8UK_k9A6OJc0_PSkhWIhoJipA_ETR5/view?usp=sharing',
  'https://drive.google.com/file/d/1btWU4SdCgj4ugtE53KwCPUPGZOtGEV40/view?usp=sharing',
  'https://drive.google.com/file/d/1cXmrOnCTe92gvn6di604URr5BeshB0AY/view?usp=sharing',
  'https://drive.google.com/file/d/1G5KjRXIrZnefwRPu8GV23YcpRYDfWuwX/view?usp=sharing',
  'https://drive.google.com/file/d/1-JV3pD7XdPDY2hdGNmixQDv-RMdZznPb/view?usp=sharing',
  'https://drive.google.com/file/d/1YAR7s5dnY6USquKH9-ZgHQWFu4GbjFzK/view?usp=sharing',
  'https://drive.google.com/file/d/1NYoQwhwohqJnlxQovpgZO-_MYII4u3Vs/view?usp=sharing',
  'https://drive.google.com/file/d/1DzBJu2LQySAuj-6K-eXrF_bibl8ah-s_/view?usp=sharing',
  'https://drive.google.com/file/d/1f4dthkp8g1abXQg71tn6S48mcl6nMdfL/view?usp=sharing',
  'https://drive.google.com/file/d/1B7WhqGsDmvZOO1XE5_y2dWQ5ZkEHFA2k/view?usp=sharing',
  'https://drive.google.com/file/d/1gpDRufF-tEm5nd9G8jcXYWpA2IrR2vy4/view?usp=sharing',
  'https://drive.google.com/file/d/144kWtfp4Klsouq7orcA4Q-npmTVgurfm/view?usp=sharing',
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
