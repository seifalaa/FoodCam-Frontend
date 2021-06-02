import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodcam_frontend/constants.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<String> _recipes = [
    'Apple pie',
    'Spaghetti with meat balls',
    'Fried chicken',
    'Fish and chips',
    'Sushi'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.clear,
          color: KTextColor,
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back_rounded,
        color: KTextColor,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != '') {
      List<String> _filteredRecipes = _recipes
          .where((element) =>
              element.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
      return ListView.builder(
        itemCount: _filteredRecipes.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  onTap: () {}, //TODO:: Navigate to recipe page here
                  borderRadius: BorderRadius.circular(15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'lib/assets/gettyimages-154963660-612x612.jpg',
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _filteredRecipes[index],
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        color: KTextColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Lunch meal',
                                        style: TextStyle(
                                          color: Color(0x90262626),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            for (var i = 0; i < 5; i++)
                              Icon(
                                Icons.star_rounded,
                                color: Colors.orangeAccent,
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Divider(
                  indent: 10.0,
                  endIndent: 10.0,
                  color: Color(0x80262626),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.search_off_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'No results found',
                style: TextStyle(
                  color: KTextColor,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> _filteredRecipes = [];
    if (query != '') {
      _filteredRecipes = _recipes
          .where((element) =>
              element.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
      if (_filteredRecipes.isNotEmpty) {
        return ListView.builder(
          itemCount: _filteredRecipes.length,
          itemBuilder: (context, index) => Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: () {}, //TODO:: Navigate to recipe page here
                    borderRadius: BorderRadius.circular(15),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'lib/assets/gettyimages-154963660-612x612.jpg',
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _filteredRecipes[index],
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          color: KTextColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          'Lunch meal',
                                          style: TextStyle(
                                            color: Color(0x90262626),
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              for (var i = 0; i < 5; i++)
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.orangeAccent,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Divider(
                    indent: 10.0,
                    endIndent: 10.0,
                    color: Color(0x80262626),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.search_off_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'No results found',
                  style: TextStyle(
                    color: KTextColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } else
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: KPrimaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Start searching for recipes',
                style: TextStyle(
                  color: KTextColor,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      );
  }
}
