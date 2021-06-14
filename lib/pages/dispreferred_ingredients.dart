import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodcam_frontend/constants.dart';
import 'package:foodcam_frontend/widgets/bottom_navigation_bar.dart';
import 'package:foodcam_frontend/widgets/collection_box.dart';
import 'package:foodcam_frontend/widgets/preferred_search_delegate.dart';
import 'package:foodcam_frontend/widgets/search_delegate.dart';
import 'package:foodcam_frontend/widgets/text_form_field.dart';

class DisPreferrredIngredients extends StatefulWidget {
  const DisPreferrredIngredients({Key? key,
  
  
  }) : super(key: key);
 

  @override
  _DisPreferrredIngredientsState createState() => _DisPreferrredIngredientsState();
}

class _DisPreferrredIngredientsState extends State<DisPreferrredIngredients> {
 

  @override
  Widget build(BuildContext context) {
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
              'Disliked Ingredients' ,
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
      body: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          CollectionBox(
            category: 'Meat',
            imagePath: 'lib/assets/meat-80049790.png',
            isRecipe: false,
            isIngredient: true,
            
          ),
          CollectionBox(
            category: 'Meat',
            imagePath: 'lib/assets/meat-80049790.png',
                        isRecipe: false,
            isIngredient: true,

            
          ),
          CollectionBox(
            category: 'Meat',
            imagePath: 'lib/assets/meat-80049790.png',
                        isRecipe: false,
            isIngredient: true,

            
          ),
          CollectionBox(
            category: 'Meat',
            imagePath: 'lib/assets/meat-80049790.png',
            isRecipe: false,
            isIngredient: true,

            
          ),
          CollectionBox(
            category: 'Meat',
            imagePath: 'lib/assets/meat-80049790.png',
                       isRecipe: false,
            isIngredient: true,

            
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black12,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                    showSearch(
                  context: context,
                  delegate:PreferredSearchDelegate(),
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
