import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/drawer.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
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
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: CustomDrawer(name: "Saeed Muhammed",),
      bottomNavigationBar: CustomButtonNavigationBar(),
      body: Center(
          child: CustomTabView(
        tabs: ['tab1', 'tab2', 'tab3'],
        pages: [
          ListView(
            children: [
              RecipeBox(),
              RecipeBox(),
              RecipeBox(),
              RecipeBox(),
              RecipeBox(),
              RecipeBox(),
            ],
          ),
          Container(
            color: Colors.green,
            child: Center(
              child: Text('page2'),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Center(
              child: Text('page3'),
            ),
          ),
        ],
      )),
    );
  }
}
