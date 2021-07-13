import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/controllers/homepage_controller.dart';
import 'package:foodcam_frontend/models/ingredient.dart';
import 'package:foodcam_frontend/pages/empty_dispreferred_page.dart';
import 'package:foodcam_frontend/providers/lang_provider.dart';
import 'package:foodcam_frontend/widgets/add_box.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/collection_box.dart';
import 'package:foodcam_frontend/widgets/ingredient_box.dart';
import 'package:foodcam_frontend/widgets/preferred_search_delegate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class DisPreferrredIngredients extends StatefulWidget {
  const DisPreferrredIngredients({Key? key,
  
  
  }) : super(key: key);
 

  @override
  _DisPreferrredIngredientsState createState() => _DisPreferrredIngredientsState();
}

class _DisPreferrredIngredientsState extends State<DisPreferrredIngredients> {
 
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final HomePageController _controller = HomePageController();

  @override
  Widget build(BuildContext context) {
    final String langCode = Provider.of<LanguageProvider>(context).langCode;
        return Scaffold(
           extendBody: true,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: KTextColor,
              ),
            ),
            title: Text(
              AppLocalizations.of(context)!.disIng ,
          style: TextStyle(color: KTextColor),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: KPrimaryColor,
        onPressed: () {},
        child: Icon(
          Icons.shopping_basket_rounded,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: CustomButtonNavigationBar(),
      body:StreamBuilder(
        stream: langCode =='ar'?
        _fireStore.collection('DisPreferredIngredients-ar').snapshots()
        :_fireStore.collection('DisPreferredIngredients').snapshots(),


        
        builder: ( context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) { 
        return snapshot.hasData ? 
        snapshot.data!.docs.length!=0 ?
        GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
           for (int i = 0 ;i < snapshot.data!.docs.length ;i++)
                FutureBuilder<Ingredient>(
                  future:_controller.ingredientFromQueryDocumentSnapshot(snapshot.data!.docs[i]) ,
                  builder: (context, ingredientSnapshot) {
                                return ingredientSnapshot.hasData
                                    ? IngredientBox(
                                        ingredient: ingredientSnapshot.data!,
                                        index: i,
                                        onDelete: deleteItem,
                                      )
                                    : Container();
                              }),
                        AddBox(onTab: addItem),

        ],  
  )
              : EmptyDisPreferredPage()
                  : Center(
                      child: CircularProgressIndicator(
                        color: KPrimaryColor,
                      ),
                    );
            }),

       
       
   
    );
  }

  deleteItem() {
  }

  addItem() {
     showSearch(
                        context: context,
                        delegate: PreferredSearchDelegate('disPreferred'),
                      );
  }
 
}
