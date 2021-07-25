import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/models/collection.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/pages/empty_collection_recipe_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/collection_recipe_box.dart';
import 'package:foodcam_frontend/widgets/collection_search_delegate.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class CollectionsRecipes extends StatefulWidget {
  const CollectionsRecipes({
    Key? key,
    required this.collection,
  }) : super(key: key);
  final Collection collection;

  @override
  _CollectionsRecipesState createState() => _CollectionsRecipesState();
}

class _CollectionsRecipesState extends State<CollectionsRecipes> {
  final BackEndController _backendController = BackEndController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final String _langCode = Provider.of<LanguageProvider>(context).getLangCode;
    String collectionName = "";
    if (_langCode == "ar") {
      if (widget.collection.collectionName == 'Breakfast') {
        collectionName = "فطور";
      } else if (widget.collection.collectionName == 'Dinner') {
        collectionName = "عشاء";
      } else if (widget.collection.collectionName == 'Launch') {
        collectionName = "غداء";
      } else {
        collectionName = widget.collection.collectionName;
      }
    } else {
      collectionName = widget.collection.collectionName;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: kTextColor,
          ),
        ),
        title: Text(
          collectionName,
          style: const TextStyle(color: kTextColor),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {},
        child: const Icon(
          Icons.shopping_basket_rounded,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: const CustomButtonNavigationBar(),
      body: LoadingOverlay(
        color: Colors.black.withOpacity(0.3),
        isLoading: _isLoading,
        progressIndicator: const CircularProgressIndicator(
          color: kPrimaryColor,
        ),
        child: StreamBuilder<List<Recipe>>(
            stream: Stream.fromFuture(
              _backendController.getCollectionRecipes(
                widget.collection.id,
                _langCode,
              ),
            ),
            builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return GridView(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 600,
                      childAspectRatio: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    children: [
                      for (int i = 0; i < snapshot.data!.length; i++)
                        CollectionRecipeBox(
                          collection: widget.collection,
                          recipe: snapshot.data![i],
                          onDelete: deleteItem,
                        ),
                      AddBox(
                        onTab: () {
                          showSearch(
                              context: context,
                              delegate: CollectionRecipeSearchDelegate(
                                collection: widget.collection,
                              ));
                        },
                      ),
                    ],
                  );
                } else {
                  return EmptyCollectionRecipePage(
                    collectionName: widget.collection,
                  );
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
    );
  }

  Future<void> deleteItem(int recipeId, int collectionId) async {
    setState(() {
      _isLoading = true;
    });
    await _backendController.deleteRecipeFromCollection(recipeId, collectionId);
    setState(() {
      _isLoading = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CollectionsRecipes(collection: widget.collection),
      ),
    );
  }
}
