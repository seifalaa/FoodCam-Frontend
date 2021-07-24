import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import 'package:foodcam_frontend/widgets/search_delegate.dart';
import '../constants.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    Key? key,
    required this.category,
  }) : super(key: key);
  final Category category;

  @override
  Widget build(BuildContext context) {
    final BackEndController _backEndController = BackEndController();
    final String _langCode = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kTextColor),
        title: Text(
          category.categoryName,
          style: const TextStyle(
            color: kTextColor,
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
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: StreamBuilder<List<Recipe>>(
          stream: Stream.fromFuture(_backEndController.getCategoryRecipes(
              category.categoryId, _langCode)),
          builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
            return snapshot.hasData
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 600,
                        childAspectRatio: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      children: [
                        for (var i = 0; i < snapshot.data!.length; i++)
                          RecipeBox(recipe: snapshot.data![i]),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
          }),
    );
  }
}
