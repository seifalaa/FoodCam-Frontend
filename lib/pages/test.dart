import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/category.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/widgets/category_box.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  HomePageController _homePageController = HomePageController();
  StreamController<List<Category>> _streamController =
      StreamController.broadcast();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeStreamController();
  }

  Future<void> _initializeStreamController() async {
    await _homePageController
        .getCategories('ar')
        .then((value) => _streamController.add(value));
  }

  Future<void> _handleRefresh() async {
    await _homePageController
        .getCategories('ar')
        .then((value) => _streamController.add(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: StreamBuilder<List<Category>>(
            stream: _streamController.stream,
            builder: (context, AsyncSnapshot<List<Category>> snapshot) {
              return snapshot.hasData
                  ? GridView.builder(
                      itemCount: snapshot.data!.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 600,
                        childAspectRatio: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return CategoryBox(category: snapshot.data![index]);
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: KPrimaryColor,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
