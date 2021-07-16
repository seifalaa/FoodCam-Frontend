import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/category.dart';

import '../constants.dart';
import 'category_box.dart';

class Categories extends StatefulWidget {
  const Categories(
      {Key? key, required this.homePageController, required this.langCode})
      : super(key: key);

  final HomePageController homePageController;
  final String langCode;

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final StreamController<List<Category>> _streamController =
      StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _initializeStreamController();
  }

  Future<void> _initializeStreamController() async {
    await widget.homePageController
        .getCategories(widget.langCode)
        .then((value) => _streamController.add(value));
  }

  Future<void> _handleRefresh() async {
    await widget.homePageController
        .getCategories(widget.langCode)
        .then((value) => _streamController.add(value));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: StreamBuilder<List<Category>>(
        stream: _streamController.stream,
        builder: (context, AsyncSnapshot<List<Category>> snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 600,
                    childAspectRatio: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryBox(category: snapshot.data![index]);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                );
        },
      ),
    );
  }
}
