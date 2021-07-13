import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/pages/empty_recentlysearch_page.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';

import '../constants.dart';

class RecentlySearched extends StatefulWidget {
  const RecentlySearched({
    Key? key,
    required this.homePageController,
    required this.langCode,
  }) : super(key: key);
  final HomePageController homePageController;
  final String langCode;
  @override
  _RecentlySearchedState createState() => _RecentlySearchedState();
}

class _RecentlySearchedState extends State<RecentlySearched> {
    StreamController<List<Recipe>> _streamController =
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
    await widget.homePageController
        .getRecentlySearched(widget.langCode)
        .then((value) => _streamController.add(value));
  }

  Future<void> _handleRefresh() async {
    await widget.homePageController
        .getRecentlySearched(widget.langCode)
        .then((value) => _streamController.add(value));
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: StreamBuilder<List<Recipe>>(
        stream: _streamController.stream,
        builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
          return snapshot.hasData
              ?  snapshot.data!.length !=0  ? GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 600,
                    childAspectRatio: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return RecipeBox(
                      recipe: snapshot.data![index],
                    );
                  },
                )
                :EmptyRecentlySearch()
              : Center(
                  child: CircularProgressIndicator(
                    color: KPrimaryColor,
                  ),
                );
        },
      ),
    );;
  }
}
