import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/collection_box.dart';
import 'package:foodcam_frontend/widgets/text_form_field.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  TextEditingController _collectionNameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: KTextColor,
          ),
        ),
        title: Text(
          'Collections',
          style: TextStyle(color: KTextColor),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {},
        child: Icon(
          Icons.shopping_basket_rounded,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: CustomButtonNavigationBar(),
      body: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          CollectionBox(
            category: 'test',
            imagePath: 'lib/assets/breakfast2.jpg',
            recipeNumber: 'test',
          ),
          CollectionBox(
            category: 'test',
            imagePath: 'lib/assets/breakfast2.jpg',
            recipeNumber: 'test',
          ),
          CollectionBox(
            category: 'test',
            imagePath: 'lib/assets/breakfast2.jpg',
            recipeNumber: 'test',
          ),
          CollectionBox(
            category: 'test',
            imagePath: 'lib/assets/breakfast2.jpg',
            recipeNumber: 'test',
          ),
          CollectionBox(
            category: 'test',
            imagePath: 'lib/assets/breakfast2.jpg',
            recipeNumber: 'test',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black12,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Material(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  elevation: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text(
                                        'Create Collection',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 30.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomTextFormField(
                                    validator: (input) {
                                      return input == ''
                                          ? 'Collection name cannot be empty'
                                          : null;
                                    },
                                    hint: 'Collection name',
                                    controller: _collectionNameController,
                                    isObscure: false,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: KPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          print('valid');
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          'Create',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
