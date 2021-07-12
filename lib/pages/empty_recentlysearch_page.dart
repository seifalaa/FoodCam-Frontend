import 'package:flutter/material.dart';

import '../constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyRecentlySearch extends StatelessWidget {
  const EmptyRecentlySearch({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Opacity(
            opacity: 0.3,
            child: Image.asset(
              'lib/assets/nosearch.png',
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child:Text(
            AppLocalizations.of(context)!.noRecentlySearch,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: KTextColor,
            ),
          ),
          )
          
        ],
      ),
    );
  }
}