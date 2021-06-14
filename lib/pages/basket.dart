import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/pages/search_results.dart';
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
  @override
  Widget build(BuildContext context) {
    List<String> _items = [];
    File _image;
    final picker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Basket',
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
                    child: DraggableScrollableSheet(
                      maxChildSize: 0.4,
                      minChildSize: 0.3,
                      initialChildSize: 0.3,
                      builder: (context, scrollController) => Container(
                        color: KBgColor,
                        child: Material(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Material(
                                      elevation: 1,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Add Ingredient',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: KTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ListView(
                                shrinkWrap: true,
                                controller: scrollController,
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.camera_alt_outlined,
                                      color: KTextColor,
                                    ),
                                    title: Text(
                                      'Scan Ingredient',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap: () async {
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
                                    },
                                  ),
                                  Divider(),
                                  ListTile(
                                    leading: Icon(
                                      Icons.search_rounded,
                                      color: KTextColor,
                                    ),
                                    title: Text(
                                      'Search for ingredient',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    onTap: () {
                                      showSearch(
                                        context: context,
                                        delegate: PreferredSearchDelegate(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                      'Add ingredients to start',
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          : GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              children: [
                for (int i = 0; i < _items.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CollectionBox(
                      imagePath:
                          'lib/assets/5dad7f27320ca_HERO-alergia-al-pescado.jpg',
                      category: _items[i],
                      isRecipe: false,
                      isIngredient: true,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => makeDismissible(
                            child: DraggableScrollableSheet(
                              maxChildSize: 0.4,
                              minChildSize: 0.3,
                              initialChildSize: 0.3,
                              builder: (context, scrollController) => Container(
                                color: KBgColor,
                                child: Material(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Material(
                                              elevation: 1,
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Text(
                                                    'Add Ingredient',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25,
                                                      color: KTextColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ListView(
                                        shrinkWrap: true,
                                        controller: scrollController,
                                        children: [
                                          ListTile(
                                            leading: Icon(
                                              Icons.camera_alt_outlined,
                                              color: KTextColor,
                                            ),
                                            title: Text(
                                              'Scan Ingredient',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            onTap: () async {
                                              final pickedImage =
                                                  await picker.getImage(
                                                source: ImageSource.camera,
                                              );
                                              setState(() {
                                                if (pickedImage != null) {
                                                  _image =
                                                      File(pickedImage.path);
                                                } else {
                                                  print('No image selected.');
                                                }
                                              });
                                            },
                                          ),
                                          Divider(),
                                          ListTile(
                                            leading: Icon(
                                              Icons.search_rounded,
                                              color: KTextColor,
                                            ),
                                            title: Text(
                                              'Search for ingredient',
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            onTap: () {
                                              showSearch(
                                                context: context,
                                                delegate:
                                                    PreferredSearchDelegate(),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            context: context,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.add_rounded,
                        size: 50,
                        color: KBgColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
