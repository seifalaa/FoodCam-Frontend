import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/widgets/recipe_rate_buttom_sheet.dart';
import 'package:foodcam_frontend/widgets/recipe_steps_bottom_sheet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({
    Key? key,
    required this.recipe,
  }) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final String _lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            elevation: 1,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => makeDismissible(
              child: RecipeStepsBottomSheet(
                steps: recipe.steps,
              ),
              context: context,
            ),
          );
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.receipt_long_rounded,
          color: Colors.white,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            snap: true,
            floating: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        recipe.recipeName,
                      ),
                      Padding(
                        padding: _lang == 'ar'
                            ? const EdgeInsets.only(right: 10.0)
                            : const EdgeInsets.only(left: 10.0),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.white54,
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => makeDismissible(
                                  child: const RecipeRateBottomSheet(),
                                  context: context,
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: _lang == 'ar'
                                    ? buildRateButton().reversed.toList()
                                    : buildRateButton().toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'وجبة غداء  -  30 دقيقة',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Image(
                      image: CachedNetworkImageProvider(recipe.recipeImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: const Color(0x40000000),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Material(
              elevation: 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      AppLocalizations.of(context)!.nutritionInfo,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularPercentIndicator(
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                          animationDuration: 1200,
                          radius: 50.0,
                          lineWidth: 10.0,
                          percent: 0.4,
                          center: const Text('40%'),
                          progressColor: kPrimaryColor,
                          footer: Text(
                            AppLocalizations.of(context)!.protein,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularPercentIndicator(
                          circularStrokeCap: CircularStrokeCap.round,
                          radius: 50.0,
                          lineWidth: 10.0,
                          percent: 0.3,
                          animation: true,
                          animationDuration: 1200,
                          center: const Text('30%'),
                          progressColor: kPrimaryColor,
                          footer: Text(
                            AppLocalizations.of(context)!.carb,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularPercentIndicator(
                          circularStrokeCap: CircularStrokeCap.round,
                          radius: 50.0,
                          lineWidth: 10.0,
                          percent: 0.3,
                          animation: true,
                          animationDuration: 1200,
                          center: const Text('30%'),
                          progressColor: kPrimaryColor,
                          footer: Text(
                            AppLocalizations.of(context)!.sugar,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularPercentIndicator(
                          circularStrokeCap: CircularStrokeCap.round,
                          radius: 50.0,
                          lineWidth: 10.0,
                          percent: 0.3,
                          animation: true,
                          animationDuration: 1200,
                          center: const Text('30%'),
                          progressColor: kPrimaryColor,
                          footer: Text(
                            AppLocalizations.of(context)!.cal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      AppLocalizations.of(context)!.ingredients,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  for (int i = 0; i < recipe.ingredients.length; i++)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Material(
                                    borderRadius: BorderRadius.circular(20),
                                    elevation: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image(
                                        image: CachedNetworkImageProvider(recipe
                                            .ingredients[i].ingredientImageUrl),
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: _lang == 'ar'
                                        ? const EdgeInsets.only(right: 20.0)
                                        : const EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      recipe.ingredients[i].ingredientName,
                                      style: const TextStyle(
                                        color: kTextColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Text('2 pce'),
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildRateButton() {
    return [
      const Icon(
        Icons.star_rounded,
        color: Color(0xFFFFC107),
      ),
      Text(
        recipe.recipeRate.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
  }
}
