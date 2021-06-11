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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
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
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          bottom: const TabBar(
            labelPadding: EdgeInsets.all(10.0),
            indicatorColor: KPrimaryColor,
            labelStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            labelColor: KPrimaryColor,
            unselectedLabelColor: KTextColor,
            unselectedLabelStyle: TextStyle(
              fontSize: 17,
            ),
            tabs: [
              Text(
                'Top Rated',
              ),
              Text(
                'Categories',
              ),
              Text(
                'Recently Searched',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              itemCount: 50,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 600,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
              ),
              itemBuilder: (BuildContext context, int index) {
                return RecipeBox();
              },
            ),
            GridView.builder(
              itemCount: 50,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 600,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
              ),
              itemBuilder: (BuildContext context, int index) {
                return RecipeBox();
              },
            ),
            GridView.builder(
              itemCount: 50,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 600,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
              ),
              itemBuilder: (BuildContext context, int index) {
                return RecipeBox();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          elevation: 20,
          backgroundColor: KPrimaryColor,
          child: Icon(
            Icons.shopping_basket_rounded,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: const CustomButtonNavigationBar(),
        ),
      ),
    );
  }
}
