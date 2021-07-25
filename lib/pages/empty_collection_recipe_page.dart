import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodcam_frontend/models/collection.dart';
import 'package:foodcam_frontend/widgets/collection_search_delegate.dart';

import '../constants.dart';

class EmptyCollectionRecipePage extends StatelessWidget {
  const EmptyCollectionRecipePage({Key? key,required this.collectionName}) : super(key: key);
  final Collection collectionName;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.startRecipe,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: kTextColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: CollectionRecipeSearchDelegate(collection: collectionName));
              },
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.addRecipe,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
