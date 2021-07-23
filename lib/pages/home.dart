import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/backend_controller.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/pages/basket.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/categories.dart';
import 'package:foodcam_frontend/widgets/random_recipe_bootom_sheet.dart';
import 'package:foodcam_frontend/widgets/recently_searched.dart';
import 'package:foodcam_frontend/widgets/search_delegate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/widgets/top_rated.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BackEndController _backendController = BackEndController();
    final String _langCode = Localizations.localeOf(context).languageCode;
    final double _screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kTextColor),
          title: Text(
            AppLocalizations.of(context)!.home,
            style: const TextStyle(
              color: kTextColor,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => makeDismissible(
                  child: const RandomRecipeBottomSheet(),
                  context: context,
                ),
              );
            },
            icon: const Icon(
              Icons.shuffle_rounded,
              color: kTextColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          bottom: TabBar(
            labelPadding: const EdgeInsets.all(10.0),
            indicatorColor: kPrimaryColor,
            labelStyle: TextStyle(
              fontSize: _screenWidth * 0.040,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
            labelColor: kPrimaryColor,
            unselectedLabelColor: kTextColor,
            unselectedLabelStyle: TextStyle(
              fontSize: _screenWidth * 0.040,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
            tabs: [
              Text(
                AppLocalizations.of(context)!.topRated,
              ),
              Text(
                AppLocalizations.of(context)!.categories,
              ),
              Text(
                AppLocalizations.of(context)!.recentSearch,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TopRated(
                backendController: _backendController, langCode: _langCode),
            Categories(
                backendController: _backendController, langCode: _langCode),
            RecentlySearched(
                backendController: _backendController, langCode: _langCode),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BasketPage(),
              ),
            );
          },
          elevation: 20,
          backgroundColor: kPrimaryColor,
          child: const Icon(
            Icons.shopping_basket_rounded,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomButtonNavigationBar(),
      ),
    );
  }
}
