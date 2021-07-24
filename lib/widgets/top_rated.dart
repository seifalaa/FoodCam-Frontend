import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';

import '../constants.dart';

class TopRated extends StatefulWidget {
  const TopRated(
      {Key? key, required this.backendController, required this.langCode})
      : super(key: key);
  final BackEndController backendController;
  final String langCode;

  @override
  _TopRatedState createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  final StreamController<List<Recipe>> _streamController =
      StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _initializeStreamController();
  }

  Future<void> _initializeStreamController() async {
    await widget.backendController
        .getTopRated(widget.langCode)
        .then((value) => _streamController.add(value));
  }

  Future<void> _handleRefresh() async {
    await widget.backendController
        .getTopRated(widget.langCode)
        .then((value) => _streamController.add(value));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: kPrimaryColor,
      onRefresh: _handleRefresh,
      child: StreamBuilder<List<Recipe>>(
        stream: _streamController.stream,
        builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
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
                    return RecipeBox(
                      recipe: snapshot.data![index],
                    );
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
