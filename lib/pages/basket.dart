import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/models/user.dart';
import 'package:foodcam_frontend/pages/search_results.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
import 'package:foodcam_frontend/widgets/add_ingredient_bottom_sheet.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/pages/empty_basket_page.dart';
import 'package:foodcam_frontend/widgets/ingredient_box.dart';
import 'package:foodcam_frontend/widgets/unloggedin_user_basket.dart';

//import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  //final picker = ImagePicker();
  final BackEndController _backendController = BackEndController();

  //final HomePageController _controller = HomePageController();
  // final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late File _image;
  bool _isLoading = false;

  Future<void> pickImage() async {
    // final pickedImage = await picker.getImage(
    //   source: ImageSource.camera,
    // );
    // setState(() {
    //   if (pickedImage != null) {
    //     _image = File(pickedImage.path);
    //   }
    // });
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

  Future<void> deleteItem(int ingredientId) async {
    setState(() {
      _isLoading = true;
    });
    await _backendController.deleteIngredientFromBasket(ingredientId);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String _langCode = Localizations.localeOf(context).languageCode;
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
        stream: Stream.fromFuture(
            _backendController.getBasketIngredients(_langCode)),
        builder: (context, AsyncSnapshot<List<Ingredient>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
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
                        ingredientsDocs: snapshot.data!,
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
        child: FutureBuilder<User?>(
            future: getUserInfo(),
            builder: (context, AsyncSnapshot<User?> snapshot) =>
                snapshot.connectionState != ConnectionState.waiting
                    ? snapshot.data == null
                        ? const UnLoggedInUserBasket()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: StreamBuilder(
                                stream: Stream.fromFuture(_backendController
                                    .getBasketIngredients(_langCode)),
                                builder: (context,
                                    AsyncSnapshot<List<Ingredient>> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!.isNotEmpty) {
                                      return GridView(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 250,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                        ),
                                        children: [
                                          for (int i = 0;
                                              i < snapshot.data!.length;
                                              i++)
                                            //Container(),

                                            IngredientBox(
                                              ingredient: snapshot.data![i],
                                              index: i,
                                              onDelete: deleteItem,
                                            ),
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
                          )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      )),
      ),
    );
  }

  Future<User?> getUserInfo() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final String? userName = _sharedPreferences.getString('userName');
    final String? firstName = _sharedPreferences.getString('firstName');
    final String? lastName = _sharedPreferences.getString('lastName');
    return userName != null && firstName != null && lastName != null
        ? User(firstName: firstName, lastName: lastName, userName: userName)
        : null;
  }
}
