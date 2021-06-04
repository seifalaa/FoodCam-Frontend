import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/category_box.dart';
import 'package:foodcam_frontend/widgets/drawer.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import 'package:foodcam_frontend/widgets/search_delegate.dart';
import 'package:foodcam_frontend/widgets/tab_view.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: KTextColor),
        title: Text(
          'Home',
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        name: "Saeed Muhammed",
      ),
      body: Stack(
        children: [
          Center(
            child: CustomTabView(
              tabs: ['Top rated', 'Categories', 'Recently searched'],
              pages: [
                GridView.count(
                    childAspectRatio: 2,
                    crossAxisCount:
                        MediaQuery.of(context).size.width <= KMobileScreenSize
                            ? 1
                            : 2,
                    children: [
                      RecipeBox(),
                      RecipeBox(),
                      RecipeBox(),
                      RecipeBox(),
                    ]),
                ListView(
                  children: [
                    CategoryBox(
                      imagePath: 'lib/assets/breakfast2.jpg',
                      category: 'Breakfast',
                    ),
                    CategoryBox(
                      imagePath: 'lib/assets/lunch2.jpg',
                      category: 'Lunch',
                    ),
                    CategoryBox(
                      imagePath: 'lib/assets/dinner2.jpg',
                      category: 'Dinner',
                    ),
                  ],
                ),
                Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text('page3'),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: CustomButtonNavigationBar(),
          ),
        ],
      ),
    );
  }
}
