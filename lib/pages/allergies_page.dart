import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/providers/allergy_provider.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/collection_box.dart';

import '../constants.dart';

class AllergiesPage extends StatefulWidget {
  const AllergiesPage({Key? key}) : super(key: key);

  @override
  _AllergiesPageState createState() => _AllergiesPageState();
}

class _AllergiesPageState extends State<AllergiesPage> {
  AllergyProvider _allergyProvider = AllergyProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Allergies',
          style: TextStyle(
            color: KTextColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: KTextColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: CustomButtonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {},
        child: Icon(
          Icons.shopping_basket_rounded,
          color: Colors.white,
        ),
      ),
      body: _allergyProvider.allergies.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'You have no allergies',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: KTextColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: KPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => makeDismissible(
                            child: DraggableScrollableSheet(
                              initialChildSize: 0.6,
                              minChildSize: 0.6,
                              maxChildSize: 0.7,
                              builder: (context, scrollController) => Container(
                                color: KBgColor,
                                child: Material(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Material(
                                              elevation: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Center(
                                                  child: Text(
                                                    'Add Allergy',
                                                    style: TextStyle(
                                                      color: KTextColor,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        controller: scrollController,
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            ListTile(
                                              title: Text('Allergy $index'),
                                              trailing: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _allergyProvider
                                                        .add('Allergy $index');
                                                  });
                                                },
                                                icon: Icon(
                                                  _allergyProvider.allergies
                                                          .contains(
                                                              'Allergy $index')
                                                      ? Icons.done_rounded
                                                      : Icons.add_rounded,
                                                  color: KPrimaryColor,
                                                ),
                                              ),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            context: context,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                for (int i = 0; i < _allergyProvider.allergies.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container()
                        ),
                        Visibility(
                          visible: _allergyProvider.allergiesLongPress[i],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black26,
                                ),
                                child: Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black12,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => makeDismissible(
                            child: DraggableScrollableSheet(
                              initialChildSize: 0.6,
                              minChildSize: 0.6,
                              maxChildSize: 0.7,
                              builder: (context, scrollController) => Container(
                                color: KBgColor,
                                child: Material(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Material(
                                              elevation: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Center(
                                                  child: Text(
                                                    'Add Allergy',
                                                    style: TextStyle(
                                                      color: KTextColor,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        controller: scrollController,
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            ListTile(
                                              title: Text('Allergy $index'),
                                              trailing: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _allergyProvider
                                                        .add('Allergy $index');
                                                  });
                                                },
                                                icon: Icon(
                                                  _allergyProvider.allergies
                                                          .contains(
                                                              'Allergy $index')
                                                      ? Icons.done_rounded
                                                      : Icons.add_rounded,
                                                  color: KPrimaryColor,
                                                ),
                                              ),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            context: context,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.add_rounded,
                        size: 50,
                        color: KBgColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
