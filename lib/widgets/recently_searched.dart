import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/models/user.dart';
import 'package:foodcam_frontend/pages/empty_recentlysearch_page.dart';
import 'package:foodcam_frontend/pages/unloggedin_user_page.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class RecentlySearched extends StatefulWidget {
  const RecentlySearched({
    Key? key,
    required this.backendController,
    required this.langCode,
  }) : super(key: key);
  final BackEndController backendController;
  final String langCode;

  @override
  _RecentlySearchedState createState() => _RecentlySearchedState();
}

class _RecentlySearchedState extends State<RecentlySearched> {
  final StreamController<List<Recipe>> _streamController =
      StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _initializeStreamController();
  }

  Future<void> _initializeStreamController() async {
    await widget.backendController
        .getRecentlySearched(widget.langCode)
        .then((value) => _streamController.add(value));
  }

  Future<void> _handleRefresh() async {
    await widget.backendController
        .getRecentlySearched(widget.langCode)
        .then((value) => _streamController.add(value));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,

      child:FutureBuilder<User?>(
          future: getUserInfo(),
        builder: (context, snapshot) {
    if (snapshot.connectionState != ConnectionState.waiting) {
      if (snapshot.data == null) {
        return const UnLoggedInUserPage();
      }
      else {
        return StreamBuilder<List<Recipe>>(
          stream: _streamController.stream,
          builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
            return snapshot.hasData
                ? snapshot.data!.isNotEmpty
                ? GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate:
              const SliverGridDelegateWithMaxCrossAxisExtent(
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
                : const EmptyRecentlySearch()
                : const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          },
        );
      }

      }
    else {
      return const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      );
    }
        }

      )
    );
  }



  Future<User?> getUserInfo() async {
    final SharedPreferences _sharedPreferences =
    await SharedPreferences.getInstance();
    final String? userName = _sharedPreferences.getString('userName');
    final String? firstName = _sharedPreferences.getString('firstName');
    final String? lastName = _sharedPreferences.getString('lastName');
    return userName != null && firstName != null && lastName != null
        ? User(firstName: firstName, lastName: lastName, userName: userName)
        : null;
  }
}
