import 'package:flutter/material.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/pages/category_page.dart';

import '../constants.dart';

class CategoryBox extends StatefulWidget {
  const CategoryBox({
    Key? key,
    required this.category,
  }) : super(key: key);
  final Category category;

  @override
  _CategoryBoxState createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final String _lang = Localizations.localeOf(context).languageCode;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.category.categoryImageUrl,
                //'https://lh3.googleusercontent.com/95oUJyeApyr-g6NfyGmfCLnl6omIcbtb83PCSSDuMm0OzvXCXFwrw-G7B3hN9_FeQ-6i8Vz-Esh0e2v0-COYQjo3se9f1Ap-18HbPuTEeCQe1rYbbTHyfGi4WmJ2TxX-oN5zjSHmB7odGaf4fZh8TCqtDX5p31EELJ6HF7ppQMVFIOxbu0dB8fAnvOjsxUmsbFPPD7K0eCw6oK_bgZtQe9_3qo7pDQuKhv9TQa7AnvC-YKqx5GWQ3gwEAqSPVZyjF6-48qENK1-_gf5FoxmmWMTPNANF1nOkvUil1XGh74SjMMjzaJqjnXQPxXWiTBTtZlAbK1bdd5AHeiaXap290awv1x-nOrwIW1txd616NEwZkwNkdaOc6PspwCI__1l7VURm2DbMSOh8vXtmgqdTyolcTmj8xHTpKWUH26ZfDkXpiTu9ZQPQBbT3X-tnt48hsHoeoI-VJzMs9CHeSN6_LZuwsa-j4K7raB_CTrZzetS-1QRx7EpfKbkGBlCiLWs6MT3v5P--hRlMtOTxp0n-EfRqI1rpOmYOwlWt4ryyYNDMQYSzQ5EscQTDhAO2_r5VzqKXfRFX3eBu2_JMZ_cdOwrgCkgsAX6NgjmzeQlR4SoUV7JtDNMCH1CzWxezpD7ozGznd_gt4_t-MlC8eYmnl52RGh7apdErb75ck70HtBSJC5lQx5ldMV6zTjErg4zwW8sH-vo4b5tRvw1Jm65rAQ=w626-h417-no?authuser=0',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0x40000000),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.category.categoryName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _screenWidth <= kMobileScreenSize
                          ? _screenWidth * 0.045
                          : _screenWidth * 0.0225,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      handleRecipesOrRecipe(widget.category.recipeCount, _lang),
                      style: TextStyle(
                        color: const Color(0xFFFFC107),
                        fontWeight: FontWeight.bold,
                        fontSize: _screenWidth <= kMobileScreenSize
                            ? _screenWidth * 0.038
                            : _screenWidth * 0.0194,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                highlightColor: Colors.transparent,
                splashColor: const Color(0x50D0F1DD),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(
                        category: widget.category,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String handleRecipesOrRecipe(int quantity, String langCode) {
    if (langCode == 'ar') {
      if (quantity > 1 && quantity < 11) {
        return quantity == 2 ? 'وصفتين' : '$quantity وصفات';
      } else {
        return quantity == 1 ? 'وصفة' : '$quantity وصفة ';
      }
    } else if (langCode == 'en') {
      return quantity == 1 ? '$quantity recipe' : '$quantity recipes';
    } else {
      return '';
    }
  }
}
