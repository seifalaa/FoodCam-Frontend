import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/models/collection.dart';
import 'package:foodcam_frontend/pages/collections_recipes_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CollectionBox extends StatefulWidget {
  const CollectionBox({
    Key? key,
    required this.collection,
    required this.onDelete,
  }) : super(key: key);
  final Collection collection;
  final Function onDelete;

  @override
  _CollectionBoxState createState() => _CollectionBoxState();
}

class _CollectionBoxState extends State<CollectionBox> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final String _langCode = Provider.of<LanguageProvider>(context).getLangCode;
    final BackEndController _backendController = BackEndController();
    String collectionName = "";
    if (_langCode == "ar") {
      if (widget.collection.collectionName == 'Breakfast') {
        collectionName = "فطور";
      }
      else if (widget.collection.collectionName == 'Dinner') {
        collectionName = "عشاء";
      }
      else if (widget.collection.collectionName == 'Launch') {
        collectionName = "غداء";
      }
      else{collectionName = widget.collection.collectionName;}
    } else {
      collectionName = widget.collection.collectionName;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: //Image.asset('lib/assets/avatar.png' , fit:BoxFit.cover ,),
               
              Image.network(
                //widget.collection.collectionImageUrl
                'https://lh3.googleusercontent.com/95oUJyeApyr-g6NfyGmfCLnl6omIcbtb83PCSSDuMm0OzvXCXFwrw-G7B3hN9_FeQ-6i8Vz-Esh0e2v0-COYQjo3se9f1Ap-18HbPuTEeCQe1rYbbTHyfGi4WmJ2TxX-oN5zjSHmB7odGaf4fZh8TCqtDX5p31EELJ6HF7ppQMVFIOxbu0dB8fAnvOjsxUmsbFPPD7K0eCw6oK_bgZtQe9_3qo7pDQuKhv9TQa7AnvC-YKqx5GWQ3gwEAqSPVZyjF6-48qENK1-_gf5FoxmmWMTPNANF1nOkvUil1XGh74SjMMjzaJqjnXQPxXWiTBTtZlAbK1bdd5AHeiaXap290awv1x-nOrwIW1txd616NEwZkwNkdaOc6PspwCI__1l7VURm2DbMSOh8vXtmgqdTyolcTmj8xHTpKWUH26ZfDkXpiTu9ZQPQBbT3X-tnt48hsHoeoI-VJzMs9CHeSN6_LZuwsa-j4K7raB_CTrZzetS-1QRx7EpfKbkGBlCiLWs6MT3v5P--hRlMtOTxp0n-EfRqI1rpOmYOwlWt4ryyYNDMQYSzQ5EscQTDhAO2_r5VzqKXfRFX3eBu2_JMZ_cdOwrgCkgsAX6NgjmzeQlR4SoUV7JtDNMCH1CzWxezpD7ozGznd_gt4_t-MlC8eYmnl52RGh7apdErb75ck70HtBSJC5lQx5ldMV6zTjErg4zwW8sH-vo4b5tRvw1Jm65rAQ=w626-h417-no?authuser=0',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0x30000000),
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
                    collectionName,
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
                      handleRecipesOrRecipe(
                          widget.collection.recipes.length, _langCode),
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
          Visibility(
            visible: _isVisible,
            child: Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
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
                  _isVisible
                      ? setState(() {
                          _isVisible = false;
                        })
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CollectionsRecipes(
                              recipes: widget.collection.recipes,
                              collectionName: widget.collection.collectionName,
                            ),
                          ),
                        );
                },
                onLongPress: ()  {

                  setState(() {
                    _isVisible = true;
                  });
                },
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Positioned(
                child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.zero,
                  primary: Colors.red,
                ),
                onPressed: () async {
                  await widget.onDelete(
                      widget.collection.collectionName, _langCode);
                  setState(() {
                    _isVisible = false;
                  });
                },
                child: const Icon(Icons.clear),
              ),
            )),
          )
        ],
      ),
    );
  }

  String handleRecipesOrRecipe(int quantity, String langCode) {
    if (langCode == 'ar') {
      if (quantity > 1 && quantity < 11) {
        return quantity == 2 ? 'وصفتين' : '$quantity وصفات';
      } else if (quantity == 0) {
        return 'فارغة';
      } else {
        return 'وصفة';
      }
    } else if (langCode == 'en') {
      return quantity == 1 ? '$quantity recipe' : '$quantity recipes';
    } else {
      return '';
    }
  }
}
