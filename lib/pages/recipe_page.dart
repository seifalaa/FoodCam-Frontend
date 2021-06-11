import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/widgets/drawer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            elevation: 1,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => makeDismissible(
              child: DraggableScrollableSheet(
                maxChildSize: 0.7,
                minChildSize: 0.5,
                initialChildSize: 0.7,
                builder: (context, scrollController) => Container(
                  color: KBgColor,
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Material(
                        elevation: 1,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Steps',
                              style: TextStyle(
                                color: KTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      for (var i = 0; i < 20; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.arrow_right_rounded,
                                  color: KPrimaryColor,
                                ),
                                title: Text(
                                    'Sunt castores fallere superbus, fatalis impositioes Sunt castores fallere superbus, fatalis impositioes Sunt castores fallere superbus, fatalis impositioes.'),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              context: context,
            ),
          );
        },
        backgroundColor: KPrimaryColor,
        child: Icon(
          Icons.receipt_long_rounded,
          color: Colors.white,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            snap: true,
            floating: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Meat Balls'),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.white54,
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => makeDismissible(
                                    child: DraggableScrollableSheet(
                                      initialChildSize: 0.35,
                                      maxChildSize: 0.35,
                                      minChildSize: 0.3,
                                      builder: (context, scrollController) =>
                                          Container(
                                        color: KBgColor,
                                        child: Material(
                                          color: KBgColor,
                                          child: ListView(
                                            controller: scrollController,
                                            children: [
                                              Material(
                                                elevation: 1,
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Text(
                                                      'Rate',
                                                      style: TextStyle(
                                                        color: KTextColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 30,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  for (int i = 0; i < 5; i++)
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.star_rounded,
                                                        color: Colors.grey,
                                                        size: 35,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 100.0,
                                                        vertical: 20),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: KPrimaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      'Submit',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ), context: context,
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: Color(0xFFFFC107),
                                    ),
                                    Text(
                                      '3.5',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Lunch Meal - 30 Minutes',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'lib/assets/meatballs-sweet-sour-tomato-sauce-basil-wooden-bowl.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: Color(0x40000000),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Material(
              elevation: 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Nutrition Info',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: KTextColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularPercentIndicator(
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                          animationDuration: 1200,
                          radius: 50.0,
                          lineWidth: 10.0,
                          percent: 0.3,
                          center: Text('30%'),
                          progressColor: KPrimaryColor,
                          footer: Text('Protein'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularPercentIndicator(
                          circularStrokeCap: CircularStrokeCap.round,
                          radius: 50.0,
                          lineWidth: 10.0,
                          percent: 0.3,
                          animation: true,
                          animationDuration: 1200,
                          center: Text('30%'),
                          progressColor: KPrimaryColor,
                          footer: Text('Protein'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularPercentIndicator(
                          circularStrokeCap: CircularStrokeCap.round,
                          radius: 50.0,
                          lineWidth: 10.0,
                          percent: 0.3,
                          animation: true,
                          animationDuration: 1200,
                          center: Text('30%'),
                          progressColor: KPrimaryColor,
                          footer: Text('Protein'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularPercentIndicator(
                          circularStrokeCap: CircularStrokeCap.round,
                          radius: 50.0,
                          lineWidth: 10.0,
                          percent: 0.3,
                          animation: true,
                          animationDuration: 1200,
                          center: Text('30%'),
                          progressColor: KPrimaryColor,
                          footer: Text('Protein'),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: KTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  'lib/assets/istockphoto-466175630-612x612.png',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Tomato',
                                style: TextStyle(
                                    color: KTextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Text('2 pce'),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  'lib/assets/istockphoto-466175630-612x612.png',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Tomato',
                                style: TextStyle(
                                    color: KTextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Text('2 pce'),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  'lib/assets/istockphoto-466175630-612x612.png',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Tomato',
                                style: TextStyle(
                                    color: KTextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Text('2 pce'),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset(
                                  'lib/assets/istockphoto-466175630-612x612.png',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Tomato',
                                style: TextStyle(
                                    color: KTextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Text('2 pce'),
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
