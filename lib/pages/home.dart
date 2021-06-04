import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/category_box.dart';
import 'package:foodcam_frontend/widgets/drawer.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import 'package:foodcam_frontend/widgets/search_delegate.dart';
import 'package:foodcam_frontend/widgets/tab_view.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
      bottomNavigationBar: CustomButtonNavigationBar(),
      body: Center(
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

                GridView.count(
                childAspectRatio: 2,
                crossAxisCount:
                    MediaQuery.of(context).size.width <= KMobileScreenSize
                        ? 1
                        : 2,
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
                  
                ]),
           
            Container(
              color: Colors.blue,
              child: Center(
                child: Text('page3'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
