import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/models/nutrition_info.dart';
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
    final String _langCode = Localizations.localeOf(context).languageCode;
    final BackEndController _backEndController = BackEndController();
    final double _screenWidth = MediaQuery.of(context).size.width;
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
      body: StreamBuilder(
        stream: Stream.fromFuture(
          _backEndController.addRecentlySearched(recipe.recipeId),
        ),
        builder: (context, addRecentlySnapshot) => addRecentlySnapshot
                    .connectionState !=
                ConnectionState.waiting
            ? StreamBuilder<List<Ingredient>>(
                stream: Stream.fromFuture(
                  _backEndController.getRecipeIngredients(
                      recipe.recipeId, _langCode),
                ),
                builder: (context, AsyncSnapshot<List<Ingredient>> snapshot) {
                  return snapshot.hasData
                      ? CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              snap: true,
                              floating: true,
                              expandedHeight: 300,
                              flexibleSpace: FlexibleSpaceBar(
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            recipe.recipeName,
                                            style: TextStyle(
                                              fontSize: _screenWidth * 0.04,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: _langCode == 'ar'
                                                    ? const EdgeInsets.only(
                                                        right: 10.0)
                                                    : const EdgeInsets.only(
                                                        left: 10.0),
                                                child: Center(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: InkWell(
                                                      highlightColor:
                                                          Colors.transparent,
                                                      splashColor:
                                                          Colors.white54,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          context: context,
                                                          builder: (context) =>
                                                              makeDismissible(
                                                            child:
                                                                RecipeRateBottomSheet(
                                                              recipeId: recipe
                                                                  .recipeId,
                                                            ),
                                                            context: context,
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    2.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: _langCode ==
                                                                  'ar'
                                                              ? buildRateButton(
                                                                      _screenWidth)
                                                                  .reversed
                                                                  .toList()
                                                              : buildRateButton(
                                                                      _screenWidth)
                                                                  .toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        checkMinuteMinutes(
                                            recipe.prepareTime, _langCode),
                                        style: TextStyle(
                                          fontSize: _screenWidth * 0.025,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                centerTitle: true,
                                background: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.network(
                                        recipe.recipeImageUrl,
                                        //'https://lh3.googleusercontent.com/95oUJyeApyr-g6NfyGmfCLnl6omIcbtb83PCSSDuMm0OzvXCXFwrw-G7B3hN9_FeQ-6i8Vz-Esh0e2v0-COYQjo3se9f1Ap-18HbPuTEeCQe1rYbbTHyfGi4WmJ2TxX-oN5zjSHmB7odGaf4fZh8TCqtDX5p31EELJ6HF7ppQMVFIOxbu0dB8fAnvOjsxUmsbFPPD7K0eCw6oK_bgZtQe9_3qo7pDQuKhv9TQa7AnvC-YKqx5GWQ3gwEAqSPVZyjF6-48qENK1-_gf5FoxmmWMTPNANF1nOkvUil1XGh74SjMMjzaJqjnXQPxXWiTBTtZlAbK1bdd5AHeiaXap290awv1x-nOrwIW1txd616NEwZkwNkdaOc6PspwCI__1l7VURm2DbMSOh8vXtmgqdTyolcTmj8xHTpKWUH26ZfDkXpiTu9ZQPQBbT3X-tnt48hsHoeoI-VJzMs9CHeSN6_LZuwsa-j4K7raB_CTrZzetS-1QRx7EpfKbkGBlCiLWs6MT3v5P--hRlMtOTxp0n-EfRqI1rpOmYOwlWt4ryyYNDMQYSzQ5EscQTDhAO2_r5VzqKXfRFX3eBu2_JMZ_cdOwrgCkgsAX6NgjmzeQlR4SoUV7JtDNMCH1CzWxezpD7ozGznd_gt4_t-MlC8eYmnl52RGh7apdErb75ck70HtBSJC5lQx5ldMV6zTjErg4zwW8sH-vo4b5tRvw1Jm65rAQ=w626-h417-no?authuser=0',
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .nutritionInfo,
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: kTextColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 110,
                                      child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularPercentIndicator(
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              animation: true,
                                              animationDuration: 1200,
                                              radius: 65.0,
                                              lineWidth: 10.0,
                                              percent: getNutritionPercent(
                                                recipe.nutritionInfo.calories,
                                                recipe.nutritionInfo,
                                              ),
                                              center: Text('${(getNutritionPercent(
                                                    recipe
                                                        .nutritionInfo.calories,
                                                    recipe.nutritionInfo,
                                                  ) * 100).toStringAsFixed(1)}%'),
                                              progressColor: kPrimaryColor,
                                              footer: Text(
                                                AppLocalizations.of(context)!
                                                    .cal,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularPercentIndicator(
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              radius: 65.0,
                                              lineWidth: 10.0,
                                              percent: getNutritionPercent(
                                                recipe.nutritionInfo.carbs,
                                                recipe.nutritionInfo,
                                              ),
                                              animation: true,
                                              animationDuration: 1200,
                                              center: Text('${(getNutritionPercent(
                                                    recipe.nutritionInfo.carbs,
                                                    recipe.nutritionInfo,
                                                  ) * 100).toStringAsFixed(1)}%'),
                                              progressColor: kPrimaryColor,
                                              footer: Text(
                                                AppLocalizations.of(context)!
                                                    .carb,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularPercentIndicator(
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              radius: 65.0,
                                              lineWidth: 10.0,
                                              percent: getNutritionPercent(
                                                recipe.nutritionInfo.fats,
                                                recipe.nutritionInfo,
                                              ),
                                              animation: true,
                                              animationDuration: 1200,
                                              center: Text('${(getNutritionPercent(
                                                    recipe.nutritionInfo.fats,
                                                    recipe.nutritionInfo,
                                                  ) * 100).toStringAsFixed(1)}%'),
                                              progressColor: kPrimaryColor,
                                              footer: Text(
                                                AppLocalizations.of(context)!
                                                    .fat,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularPercentIndicator(
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              radius: 65.0,
                                              lineWidth: 10.0,
                                              percent: getNutritionPercent(
                                                recipe.nutritionInfo.protein,
                                                recipe.nutritionInfo,
                                              ),
                                              animation: true,
                                              animationDuration: 1200,
                                              center: Text('${(getNutritionPercent(
                                                    recipe
                                                        .nutritionInfo.protein,
                                                    recipe.nutritionInfo,
                                                  ) * 100).toStringAsFixed(1)}%'),
                                              progressColor: kPrimaryColor,
                                              footer: Text(
                                                AppLocalizations.of(context)!
                                                    .protein,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularPercentIndicator(
                                              circularStrokeCap:
                                                  CircularStrokeCap.round,
                                              radius: 65.0,
                                              lineWidth: 10.0,
                                              percent: getNutritionPercent(
                                                recipe.nutritionInfo.sugar,
                                                recipe.nutritionInfo,
                                              ),
                                              animation: true,
                                              animationDuration: 1200,
                                              center: Text('${(getNutritionPercent(
                                                    recipe.nutritionInfo.sugar,
                                                    recipe.nutritionInfo,
                                                  ) * 100).toStringAsFixed(1)}%'),
                                              progressColor: kPrimaryColor,
                                              footer: Text(
                                                AppLocalizations.of(context)!
                                                    .sugar,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .ingredients,
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
                                    for (int i = 0;
                                        i < snapshot.data!.length;
                                        i++)
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 2,
                                                  child: Row(
                                                    children: [
                                                      Material(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        elevation: 1,
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child:
                                                                Image.network(
                                                              snapshot.data![i]
                                                                  .ingredientImageUrl,
                                                              //'https://lh3.googleusercontent.com/95oUJyeApyr-g6NfyGmfCLnl6omIcbtb83PCSSDuMm0OzvXCXFwrw-G7B3hN9_FeQ-6i8Vz-Esh0e2v0-COYQjo3se9f1Ap-18HbPuTEeCQe1rYbbTHyfGi4WmJ2TxX-oN5zjSHmB7odGaf4fZh8TCqtDX5p31EELJ6HF7ppQMVFIOxbu0dB8fAnvOjsxUmsbFPPD7K0eCw6oK_bgZtQe9_3qo7pDQuKhv9TQa7AnvC-YKqx5GWQ3gwEAqSPVZyjF6-48qENK1-_gf5FoxmmWMTPNANF1nOkvUil1XGh74SjMMjzaJqjnXQPxXWiTBTtZlAbK1bdd5AHeiaXap290awv1x-nOrwIW1txd616NEwZkwNkdaOc6PspwCI__1l7VURm2DbMSOh8vXtmgqdTyolcTmj8xHTpKWUH26ZfDkXpiTu9ZQPQBbT3X-tnt48hsHoeoI-VJzMs9CHeSN6_LZuwsa-j4K7raB_CTrZzetS-1QRx7EpfKbkGBlCiLWs6MT3v5P--hRlMtOTxp0n-EfRqI1rpOmYOwlWt4ryyYNDMQYSzQ5EscQTDhAO2_r5VzqKXfRFX3eBu2_JMZ_cdOwrgCkgsAX6NgjmzeQlR4SoUV7JtDNMCH1CzWxezpD7ozGznd_gt4_t-MlC8eYmnl52RGh7apdErb75ck70HtBSJC5lQx5ldMV6zTjErg4zwW8sH-vo4b5tRvw1Jm65rAQ=w626-h417-no?authuser=0',
                                                              width: 50,
                                                              height: 50,
                                                            )
                                                            //
                                                            // Image(
                                                            //   image: CachedNetworkImageProvider(recipe
                                                            //       .ingredients[i].ingredientImageUrl),
                                                            //   width: 50,
                                                            //   height: 50,
                                                            // ),
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding: _langCode ==
                                                                'ar'
                                                            ? const EdgeInsets
                                                                    .only(
                                                                right: 20.0)
                                                            : const EdgeInsets
                                                                    .only(
                                                                left: 20.0),
                                                        child: Text(
                                                          snapshot.data![i]
                                                              .ingredientName,
                                                          style:
                                                              const TextStyle(
                                                            color: kTextColor,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    '${snapshot.data![i].ingredientAmount} ${snapshot.data![i].unit}',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
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
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        );
                },
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
      ),
    );
  }

  List<Widget> buildRateButton(double screenWidth) {
    return [
      const Icon(
        Icons.star_rounded,
        color: Color(0xFFFFC107),
      ),
      Text(
        recipe.recipeRate.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth * 0.04,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
  }

  String checkMinuteMinutes(int prepareTime, String langCode) {
    if (langCode == 'ar') {
      if (prepareTime == 2) {
        return 'دقيقتان';
      } else if (prepareTime >= 3 && prepareTime <= 10) {
        return '$prepareTime دقائق';
      } else {
        return '$prepareTime دقيقة';
      }
    } else if (langCode == 'en') {
      if (prepareTime == 1) {
        return '$prepareTime minute';
      } else {
        return '$prepareTime minutes';
      }
    } else {
      return '';
    }
  }

  double getNutritionPercent(double nutrition, NutritionInfo nutritionInfo) {
    return nutrition /
        (nutritionInfo.calories +
            nutritionInfo.carbs +
            nutritionInfo.fats +
            nutritionInfo.protein +
            nutritionInfo.sugar);
  }
}
