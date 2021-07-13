import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/recipe.dart';
import 'package:foodcam_frontend/pages/basket.dart';
import 'package:foodcam_frontend/pages/empty_preferred_page.dart';
import 'package:foodcam_frontend/pages/empty_recentlysearch_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/categories.dart';
import 'package:foodcam_frontend/widgets/recently_searched.dart';
import 'package:foodcam_frontend/widgets/recipe_box.dart';
import 'package:foodcam_frontend/widgets/search_delegate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/widgets/top_rated.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController _homePageController = HomePageController();
    final FirebaseFirestore firebase = FirebaseFirestore.instance;
    final String _langCode = Provider.of<LanguageProvider>(context).langCode;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: KTextColor),
          title: Text(
            AppLocalizations.of(context)!.home,
            style: TextStyle(
              color: KTextColor,
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
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          bottom: TabBar(
            labelPadding: EdgeInsets.all(10.0),
            indicatorColor: KPrimaryColor,
            labelStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
            labelColor: KPrimaryColor,
            unselectedLabelColor: KTextColor,
            unselectedLabelStyle: TextStyle(
              fontSize: 17,
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
                homePageController: _homePageController, langCode: _langCode),
            Categories(
                homePageController: _homePageController, langCode: _langCode),
            RecentlySearched(
                homePageController: _homePageController, langCode: _langCode),
            
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BasketPage()));
          },
          elevation: 20,
          backgroundColor: KPrimaryColor,
          child: Icon(
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
