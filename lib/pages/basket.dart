import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/pages/search_results.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
import 'package:foodcam_frontend/widgets/add_ingredient_bottom_sheet.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/collection_box.dart';
import 'package:foodcam_frontend/widgets/preferred_search_delegate.dart';
import 'package:image_picker/image_picker.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final picker = ImagePicker();
  List<String> _items = ['adsasd', 'adsad'];
  late File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.basket,
          style: TextStyle(
            color: KTextColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: KTextColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _items.isEmpty
          ? FloatingActionButton(
              backgroundColor: KPrimaryColor,
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
              child: Icon(
                Icons.add_rounded,
                color: Colors.white,
              ),
            )
          : FloatingActionButton(
              backgroundColor: KPrimaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultsPage(),
                  ),
                );
              },
              child: Icon(
                Icons.search_rounded,
                color: Colors.white,
              ),
            ),
      bottomNavigationBar: CustomButtonNavigationBar(),
      body: _items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      'lib/assets/groceries.png',
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      AppLocalizations.of(context)!.addIngToStart,
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                children: [
                  for (int i = 0; i < _items.length; i++)
                    CollectionBox(
                      imagePath:
                          'lib/assets/5dad7f27320ca_HERO-alergia-al-pescado.jpg',
                      category: _items[i],
                      isRecipe: false,
                      isIngredient: true,
                    ),
                  AddBox(onTab: addItem),
                ],
              ),
            ),
    );
  }

  void pickImage() async {
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
    );
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
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
}
