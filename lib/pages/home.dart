import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/recipe_controller.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/pages/basket.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/category_box.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import 'package:foodcam_frontend/widgets/search_delegate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RecipeController _recipeController = RecipeController();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: KTextColor),
          title: Text(
            AppLocalizations.of(context)!.home,
            style: TextStyle(
              color: KTextColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          bottom: TabBar(
            labelPadding: EdgeInsets.all(10.0),
            indicatorColor: KPrimaryColor,
            labelStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
            labelColor: KPrimaryColor,
            unselectedLabelColor: KTextColor,
            unselectedLabelStyle: TextStyle(
              fontSize: 17,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
            tabs: [
              Text(
                AppLocalizations.of(context)!.topRated,
              ),
              Text(
                AppLocalizations.of(context)!.categories,
              ),
              Text(
                AppLocalizations.of(context)!.recentSearch,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: _recipeController
                  .getRecipes(Provider.of<LangUageProvider>(context).langCode),
              builder: (context, AsyncSnapshot<List<Recipe>> snapshot) =>
                  snapshot.hasData? GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 600,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return RecipeBox(
                    recipe: Recipe(
                        recipeImageUrl: snapshot.data![index].recipeImageUrl,
                        recipeName: snapshot.data![index].recipeName,
                        recipeRate: snapshot.data![index].recipeRate,
                        steps: snapshot.data![index].steps,
                        ingredients: snapshot.data![index].ingredients),
                  );
                },
              ):Center(child: CircularProgressIndicator(color: KPrimaryColor,),),
            ),
            GridView.builder(
              itemCount: 50,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 600,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return CategoryBox(
                  imagePath: 'lib/assets/breakfast2.jpg',
                  categoryName: 'فطور',
                  recipes: [
                    Recipe(
                      recipeImageUrl:
                          'lib/assets/meatballs-sweet-sour-tomato-sauce-basil-wooden-bowl.png',
                      recipeName: 'كرات لحم',
                      recipeRate: 3.5,
                      steps: ['step1', 'step2', 'step3'],
                      ingredients: [
                        Ingredient(
                            ingredientName: 'طماطم',
                            ingredientImageUrl:
                                'lib/assets/istockphoto-466175630-612x612.png'),
                        Ingredient(
                            ingredientName: 'طماطم',
                            ingredientImageUrl:
                                'lib/assets/istockphoto-466175630-612x612.png'),
                      ],
                    ),
                    Recipe(
                      recipeImageUrl:
                          'lib/assets/meatballs-sweet-sour-tomato-sauce-basil-wooden-bowl.png',
                      recipeName: 'كرات لحم',
                      recipeRate: 3.5,
                      steps: ['step1', 'step2', 'step3'],
                      ingredients: [
                        Ingredient(
                            ingredientName: 'طماطم',
                            ingredientImageUrl:
                                'lib/assets/istockphoto-466175630-612x612.png'),
                        Ingredient(
                            ingredientName: 'طماطم',
                            ingredientImageUrl:
                                'lib/assets/istockphoto-466175630-612x612.png'),
                      ],
                    ),
                    Recipe(
                      recipeImageUrl:
                          'lib/assets/meatballs-sweet-sour-tomato-sauce-basil-wooden-bowl.png',
                      recipeName: 'كرات لحم',
                      recipeRate: 3.5,
                      steps: ['step1', 'step2', 'step3'],
                      ingredients: [
                        Ingredient(
                            ingredientName: 'طماطم',
                            ingredientImageUrl:
                                'lib/assets/istockphoto-466175630-612x612.png'),
                        Ingredient(
                            ingredientName: 'طماطم',
                            ingredientImageUrl:
                                'lib/assets/istockphoto-466175630-612x612.png'),
                      ],
                    ),
                  ],
                );
              },
            ),
            GridView.builder(
              itemCount: 50,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 600,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return RecipeBox(
                  recipe: Recipe(
                      recipeImageUrl:
                          'lib/assets/meatballs-sweet-sour-tomato-sauce-basil-wooden-bowl.png',
                      recipeName: 'كرات لحم',
                      recipeRate: 3.5,
                      steps: [
                        'step1',
                        'step2',
                        'step3'
                      ],
                      ingredients: [
                        Ingredient(
                            ingredientName: 'طماطم',
                            ingredientImageUrl:
                                'lib/assets/istockphoto-466175630-612x612.png'),
                      ]),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BasketPage()));
          },
          elevation: 20,
          backgroundColor: KPrimaryColor,
          child: Icon(
            Icons.shopping_basket_rounded,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomButtonNavigationBar(),
      ),
    );
  }
}
