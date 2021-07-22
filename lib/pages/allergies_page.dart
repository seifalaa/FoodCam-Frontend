import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/allergy.dart';
import 'package:foodcam_frontend/providers/allergy_provider.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/add_allergy_bottom_sheet.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
import 'package:foodcam_frontend/widgets/allergy_box.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/widgets/empty_allergies_page.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AllergiesPage extends StatefulWidget {
  const AllergiesPage({Key? key}) : super(key: key);

  @override
  _AllergiesPageState createState() => _AllergiesPageState();
}

class _AllergiesPageState extends State<AllergiesPage> {
  final HomePageController _homePageController = HomePageController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final String _langCode = Localizations.localeOf(context).languageCode;
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
      body: LoadingOverlay(
        isLoading: _isLoading,
        color: Colors.black.withOpacity(0.2),
        progressIndicator: const CircularProgressIndicator(
          color: kPrimaryColor,
        ),
        child: StreamBuilder(
          stream: Stream.fromFuture(
            _homePageController.getUserAllergies(_langCode),
          ),
          builder: (context, AsyncSnapshot<List<Allergy>> snapshot) =>
              snapshot.hasData
                  ? snapshot.data!.isNotEmpty
                      ? GridView(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          children: [
                            for (int i = 0; i < snapshot.data!.length; i++)
                              AllergyBox(
                                allergy: snapshot.data![i],
                                onDelete: deleteItem,
                              ),
                            AddBox(
                              onTab: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) =>
                                        const AddAllergyBottomSheet());
                              },
                            ),
                          ],
                        )
                      : const EmptyAllergiesPage()
                  : const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    ),
        ),
      ),
    );
  }

  Future<void> deleteItem(String allergyName, String langCode) async {
    setState(() {
      _isLoading = true;
    });
    await _homePageController.deleteAllergy(allergyName, langCode);
    setState(() {
      _isLoading = false;
    });
  }
}
