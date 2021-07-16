import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/providers/allergy_provider.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/widgets/empty_allergies_page.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AllergiesPage extends StatefulWidget {
  const AllergiesPage({Key? key}) : super(key: key);

  @override
  _AllergiesPageState createState() => _AllergiesPageState();
}

class _AllergiesPageState extends State<AllergiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.allergies,
          style: const TextStyle(
            color: kTextColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: kTextColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: const CustomButtonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, 'basket/');
        },
        child: const Icon(
          Icons.shopping_basket_rounded,
          color: Colors.white,
        ),
      ),
      body: Provider.of<AllergyProvider>(context).allergies.isEmpty
          ? const EmptyAllergiesPage()
          : GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                for (int i = 0;
                    i < Provider.of<AllergyProvider>(context).allergies.length;
                    i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Positioned.fill(child: Container()),
                        Visibility(
                          visible: Provider.of<AllergyProvider>(context)
                              .allergiesLongPress[i],
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
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
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
                                color: kBgColor,
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
                                                    AppLocalizations.of(
                                                            context)!
                                                        .addAllergy,
                                                    style: const TextStyle(
                                                      color: kTextColor,
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
                                                    Provider.of<AllergyProvider>(
                                                            context)
                                                        .add('Allergy $index');
                                                  });
                                                },
                                                icon: Icon(
                                                  Provider.of<AllergyProvider>(
                                                              context)
                                                          .allergies
                                                          .contains(
                                                              'Allergy $index')
                                                      ? Icons.done_rounded
                                                      : Icons.add_rounded,
                                                  color: kPrimaryColor,
                                                ),
                                              ),
                                            ),
                                            const Divider(),
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
                      child: const Icon(
                        Icons.add_rounded,
                        size: 50,
                        color: kBgColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
