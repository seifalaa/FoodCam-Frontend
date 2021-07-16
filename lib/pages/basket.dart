import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/pages/search_results.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
import 'package:foodcam_frontend/widgets/add_ingredient_bottom_sheet.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/pages/empty_basket_page.dart';
import 'package:foodcam_frontend/widgets/ingredient_box.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final picker = ImagePicker();

  final HomePageController _controller = HomePageController();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late File _image;
  bool _isLoading = false;

  Future<void> pickImage() async {
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
    );
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  void addItem() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => makeDismissible(
        child: AddIngredientBottomSheet(pickImage: pickImage),
        context: context,
      ),
    );
  }

  Future<void> deleteItem(String ingredientName, String langCode) async {
    setState(() {
      _isLoading = true;
    });
    await _controller.deleteIngredientFromBasket(ingredientName, langCode);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String lang = Provider.of<LanguageProvider>(context).langCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.basket,
          style: const TextStyle(
            color: kTextColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: kTextColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: StreamBuilder(
        stream: lang == 'ar'
            ? _fireStore.collection('Basket-ar').snapshots()
            : _fireStore.collection('Basket').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return FloatingActionButton(
                backgroundColor: kPrimaryColor,
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => makeDismissible(
                      child: AddIngredientBottomSheet(pickImage: pickImage),
                      context: context,
                    ),
                  );
                },
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                ),
              );
            } else {
              return FloatingActionButton(
                backgroundColor: kPrimaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultsPage(
                        ingredientsDocs: snapshot.data!.docs,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                ),
              );
            }
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: const CustomButtonNavigationBar(),
      body: LoadingOverlay(
        isLoading: _isLoading,
        color: Colors.black,
        opacity: 0.1,
        progressIndicator: const CircularProgressIndicator(
          color: kPrimaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
              stream: lang == 'ar'
                  ? _fireStore.collection('Basket-ar').snapshots()
                  : _fireStore.collection('Basket').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return GridView(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        childAspectRatio: 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      children: [
                        for (int i = 0; i < snapshot.data!.docs.length; i++)
                          FutureBuilder<Ingredient>(
                              future: _controller
                                  .ingredientFromQueryDocumentSnapshot(
                                      snapshot.data!.docs[i]),
                              builder: (context, ingredientSnapshot) {
                                return ingredientSnapshot.hasData
                                    ? IngredientBox(
                                        ingredient: ingredientSnapshot.data!,
                                        index: i,
                                        onDelete: deleteItem,
                                      )
                                    : Container();
                              }),
                        AddBox(onTab: addItem),
                      ],
                    );
                  } else {
                    return const EmptyBasketPage();
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
